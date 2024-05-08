const PropertyChecker = require('./_sequelizePropertyChecker');

const issueFixer = (defaultValue) => (context, element, fixer) => {
    const sourceCode = context.getSourceCode();
    const source = sourceCode.getText(element);

    let useMasterValue = defaultValue;
    const transactionProperty = element.properties?.find(({ key }) => key?.name === 'transaction');
    if (transactionProperty) {
        const transactionValue = transactionProperty.value?.type === 'Identifier'
          ? transactionProperty.value?.name
          : sourceCode.getText(transactionProperty.value);
        useMasterValue = `Boolean(${transactionValue})`;
    }

    // To apply the same formatting, we need to extract the indentation pattern from the first line
    // e.g:
    // "{ model: Attachment }" => "{ useMaster: false, model: Attachment }"
    // "{\n\tmodel: Attachment }" => "{\n\tuseMaster: false,\n\tmodel: Attachment }"
    const pattern = source.match(/({\n*\s*\t*)/)[0];
    const separator = pattern.substring(1);

    const fixedSource = source?.replace(pattern, `{${separator}useMaster: ${useMasterValue},${separator}`);
    return fixer.replaceText(element, fixedSource);
};

module.exports = {
    meta: {
        type:    'problem',
        fixable: 'code',
        docs:    {
            description: 'Enforce the use of "useMaster" in Sequelize queries.'
        }
    },
    create(context) {
        const [{ defaultValue = false }] = context.options;
        return {
            CallExpression(node) {
                const propertyChecker = new PropertyChecker({
                    propertyName:  'useMaster',
                    message:       'Sequelize query options must include "useMaster".',
                    checkRoot:     true,
                    checkIncludes: false,
                    fixIssue:      issueFixer(defaultValue)
                });
                return propertyChecker.check(context, node);
            }
        };
    }
};
