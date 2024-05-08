const httpVerbs = new Set(['Get', 'Post', 'Put', 'Patch', 'Delete']);
const controllerAnnotations = new Set(['JsonController', 'Controller']);

function addWildcardPath(list, pathParts) {
  let pathRegex = '^';
  for (const part of pathParts) {
    pathRegex += part.startsWith(':') ? '/[^/]+' : `/${part}`;
  }
  pathRegex += '/?$';
  list.push({ regex: new RegExp(pathRegex), path: `/${pathParts.join('/')}/` });
}

function getWildcardOverlap(regexList, pathParts) {
  const path = `/${pathParts.join('/')}/`;
  return regexList.find(({ regex }) => regex.test(path));
}

module.exports = {
  meta: {
    type: 'problem',
    docs: {
      description: 'Checks for routes overlapping with wildcards in controllers using routing-controllers.',
      category:    'Possible Errors',
      recommended: true
    }
  },
  create(context) {
    let isInController = false;

    return {
      ClassDeclaration(node) {
        isInController = node.decorators?.some(decorator => controllerAnnotations.has(decorator.expression.callee.name));
      },
      ClassBody(node) {
        if (!isInController) {
          return;
        }

        const routeDefinitions = node.body.filter((item) =>
          item.type === 'MethodDefinition' &&
          item.decorators?.find((dec) => httpVerbs.has(dec.expression.callee.name))
        );

        const routeGroups = routeDefinitions.reduce((acc, item) => {
          const routeDecorator = item.decorators.find((dec) => httpVerbs.has(dec.expression.callee.name));
          const verb = routeDecorator.expression.callee.name;
          if (!acc.has(verb)) {
            acc.set(verb, []);
          }

          if (!routeDecorator.expression.arguments[0]) {
            return acc;
          }

          const routePath = routeDecorator.expression.arguments[0].value;
          acc.get(verb).push({ routeDecorator, routePath });

          return acc;
        }, new Map());

        for (const verb of routeGroups.keys()) {
          const wildcardPaths = [];
          for (const { routePath, routeDecorator } of routeGroups.get(verb)) {
            const pathParts = routePath.split('/').filter(Boolean);

            const overlap = getWildcardOverlap(wildcardPaths, pathParts);
            if (overlap) {
              context.report({
                node:    routeDecorator.expression.arguments[0],
                message: `Route "${routePath}" is swallowed by "${overlap.path}" wildcard`
              });
            }

            const isWildCardPath = pathParts.some((part) => part.startsWith(':'));
            if (isWildCardPath) {
              addWildcardPath(wildcardPaths, pathParts);
            }
          }
        }
      }
    };
  }
};
