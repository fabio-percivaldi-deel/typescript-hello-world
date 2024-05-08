const { ESLintUtils } = require('@typescript-eslint/utils');

const sequelizeQueryMethods = new Set(['findOne', 'findAll', 'findAndCountAll', 'findByPk']);

module.exports = {
  meta: {
    type:     'problem',
    messages: {
      attributeNotFound:         'Column {{missingAttribute}} not found in model "{{className}}". ',
      attributeNotFoundInScope:  'Column {{missingAttribute}} not found in scope "{{scopeName}}" for model "{{className}}". '
    },
    docs: {
      description: 'Enforce the use of defined model columns in "attributes" list.'
    }
  },
  create(context) {
    return {
      MemberExpression: node => {
        if (!sequelizeQueryMethods.has(node.property.name)) {
          return;
        }
        const argsIndex = node.property.name === 'findByPk' ? 1 : 0;
        const argsObject = node.parent.arguments?.[argsIndex];

        const attributesKey = argsObject?.properties?.find(prop => prop.key.name === 'attributes');
        if (!attributesKey) {
          return;
        }

        const services = ESLintUtils.getParserServices(context);
        const parentType = services.getTypeAtLocation(node).symbol?.parent;
        if (parentType?.escapedName !== 'Model') {
          return;
        }

        checkAttributes(context, services, attributesKey, node.object);
        checkIncludes(context, services, argsObject);
      }
    };
  }
};

function checkAttributes(context, services, attributesNode, modelNode) {
  if (!attributesNode || !modelNode) {
    return;
  }

  const objectAttributes = attributesNode.value?.elements?.filter(el => Boolean(el.value));
  if (!objectAttributes) {
    return;
  }

  let modelType = services.getTypeAtLocation(modelNode);

  const isAliasModel = Boolean(modelType.aliasTypeArguments?.[0]);
  if (isAliasModel) {
    modelType = modelType.aliasTypeArguments[0];
  }

  const modelMembers = new Set(modelType.symbol?.members?.keys());

  const missingAttributeNodes = objectAttributes.filter(attr => !modelMembers.has(attr.value));
  if (missingAttributeNodes.length) {
    missingAttributeNodes.forEach(attr => {
      context.report({
        messageId: isAliasModel ? 'attributeNotFoundInScope' : 'attributeNotFound',
        node:      attr,
        data:      {
          missingAttribute: `"${attr.value}"`,
          className:        modelType.symbol?.escapedName,
          scopeName:        isAliasModel ? modelNode.arguments?.[0]?.value : undefined
        }
      });
    });
  }
}
function checkIncludes(context, services, node) {
  const includesNode = node?.properties?.find(prop => prop.key?.name === 'include');
  const includesArray = includesNode?.value?.elements;
  if (!includesArray) {
    return;
  }

  includesArray.forEach(element => {
    if (element.type !== 'ObjectExpression') {
      return;
    }

    const includedModel = element.properties?.find(prop => prop.key?.name === 'model')?.value;
    const includeAttributes = element.properties?.find(prop => prop.key?.name === 'attributes');
    checkAttributes(context, services, includeAttributes, includedModel);

    checkIncludes(context, services, element);
  });
}
