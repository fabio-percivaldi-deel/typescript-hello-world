const sequelizeQueryMethods = new Set(['findOne', 'findAll', 'findAndCountAll']);

module.exports = class PropertyChecker {
    constructor({ propertyName, message, checkRoot, checkIncludes, fixIssue }) {
        this.propertyName = propertyName;
        this.checkRoot = !!checkRoot;
        this.checkIncludes = !!checkIncludes;
        this.fixIssue = fixIssue;
        this.message = message || `Sequelize query options must include "${this.propertyName}" property.`;
    }
    
    checkProperty(context, element) {
        const hasProperty = element.properties?.some(({ key }) => key?.name === this.propertyName);
        if (hasProperty) {
            return;
        }

        const reportStructure = {
            node:    element,
            message: this.message
        };
        if (this.fixIssue) {
            reportStructure.fix = (fixer) => this.fixIssue(context, element, fixer);
        }
        context.report(reportStructure);
    }
    
    checkIncludedModules(context, optionsArg) {
        const includes = optionsArg.properties?.find(({ key }) => key?.name === 'include');
        if (includes?.value?.type !== 'ArrayExpression') {
            return;
        }

        includes.value.elements.forEach((element) => {
            if (element.type !== 'ObjectExpression') {
                return;
            }
            this.checkIncludedModules(context, element);
            this.checkProperty(context, element);
        });
    }
    
    check(context, node) {
        const { callee, arguments: args } = node;
    
        if (callee.type !== 'MemberExpression' ||
            callee.property.type !== 'Identifier' ||
            !sequelizeQueryMethods.has(callee.property.name) ||
            !args?.length) {
            return;
        }
    
        const optionsArg = args[0];
        if (optionsArg.type !== 'ObjectExpression') {
            return;
        }
    
        if (this.checkRoot) {
            this.checkProperty(context, optionsArg);
        }
        if (this.checkIncludes) {
            this.checkIncludedModules(context, optionsArg);
        }
    }
};
