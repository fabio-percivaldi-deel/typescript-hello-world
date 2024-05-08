const PropertyChecker = require('./_sequelizePropertyChecker');

const propertyName = 'required';

const fixIssue = (context, element, fixer) => {
    const sourceCode = context.getSourceCode();
    const source = sourceCode.getText(element);

    // To apply the same formatting, we need to extract the indentation pattern from the first line
    // e.g:
    // "{ model: Attachment }" => "{ required: false, model: Attachment }"
    // "{\n\tmodel: Attachment }" => "{\n\trequired: false,\n\tmodel: Attachment }"
    const pattern = source.match(/({\n*\s*\t*)/)[0];
    const separator = pattern.substring(1);

    const fixedSource = source?.replace(pattern, `{${separator}required: false,${separator}`);
    return fixer.replaceText(element, fixedSource);
};

module.exports = {
    meta: {
        type:    'problem',
        fixable: 'code',
        docs:    {
            description: `Enforce the use of "${propertyName}" in Sequelize queries.`
        }
    },
    create(context) {
        return {
            CallExpression(node) {
                const propertyChecker = new PropertyChecker({ 
                    propertyName,
                    message:       'Sequelize model includes must have "required" property set (true or false).',
                    checkRoot:     false, 
                    checkIncludes: true, 
                    fixIssue 
                });
                return propertyChecker.check(context, node);
            }
        };
    }
};
