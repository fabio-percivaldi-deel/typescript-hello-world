const PropertyChecker = require('./_sequelizePropertyChecker');

module.exports = {
    meta: {
        type: 'problem',
        docs: {
            description: 'Enforce the use of "attributes" list in Sequelize queries.'
        }
    },
    create(context) {
        return {
            CallExpression(node) {
                const propertyChecker = new PropertyChecker({
                    propertyName:  'attributes',
                    message:       'Sequelize query options must define attributes array.',
                    checkRoot:     true,
                    checkIncludes: true
                });
                return propertyChecker.check(context, node);
            }
        };
    }
};
