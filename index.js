const updateQueryParam = (key, value) => {
  let currentUrl = window.location.href;
  let url = new URL(currentUrl);
  url.searchParams.set(key, value);
  window.history.pushState({}, "", url);
};

const getQueryParam = (key) => {
  const urlParams = new URLSearchParams(window.location.search);
  return urlParams.get(key);
};

function insertTypeScriptLink() {
  const specLinkElement = document.querySelector(
    ".information-container.wrapper .info .main a"
  );

  const path = specLinkElement
    ?.getAttribute("href")
    ?.match(/^(?<path>.*).json$/)?.groups?.path;

  if (path) {
    const tsLinkElement = specLinkElement.cloneNode(true);
    tsLinkElement.href = `${path}.ts`;
    tsLinkElement.innerText = `${path}.ts`;

    specLinkElement.parentNode.insertAdjacentElement(
      "beforeend",
      document.createElement("br")
    );

    specLinkElement.parentNode.insertAdjacentElement(
      "beforeend",
      tsLinkElement
    );
  }
}

const initializeSwaggerWithCustomHeader = async (event, urls) => {
  const ui = await SwaggerUIBundle({
    urls: specs,
    dom_id: "#swagger-ui",
    deepLinking: true,
    presets: [SwaggerUIBundle.presets.apis, SwaggerUIStandalonePreset],
    plugins: [
      SwaggerUIBundle.plugins.DownloadUrl,
      SwaggerUIBundle.plugins.TopBar,
    ],
    layout: "StandaloneLayout",
    onComplete: () => {
      insertTypeScriptLink();
    },
  });

  window.ui = ui;

  appendBranchSelect();
};

function appendBranchSelect() {
  const newNode = document.createElement("form");
  const label = document.createElement("label");
  const span = document.createElement("span");
  const select = document.createElement("select");

  newNode.className = "download-url-wrapper";
  newNode.appendChild(label);

  label.appendChild(span);
  label.appendChild(select);

  label.className = "select-label";
  span.textContent = "Branch: ";

  select.addEventListener("change", onBranchSelectChange);

  const list = document.getElementsByClassName("topbar-wrapper");

  list[0].insertBefore(newNode, list[0].childNodes[1]);

  if (getQueryParam("branch")) {
    select.value = getQueryParam("branch");
  }
}

async function onBranchSelectChange(e) {
  const selectedBranch = e.target.value;
  updateQueryParam("branch", selectedBranch);

  await fetchAllSpecs(selectedBranch);
  await initializeSwaggerWithCustomHeader(null, specs);
  applyOptionsToBranchesSelect(branches);
}

const applyOptionsToBranchesSelect = (branches) => {
  const branchesSelect = document.querySelector(".download-url-wrapper select");

  branches.forEach((branch) => {
    const option = document.createElement("option");
    option.value = branch;
    option.innerText = branch;

    branchesSelect.appendChild(option);
  });

  branchesSelect.value = getQueryParam("branch") || branches?.[0];
};

function fetchAllBranches() {
  const url = `${SPECS_URL}/branches.txt`;

  return fetch(url)
    .then((response) => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      return response.text();
    })
    .then((data) => {
      const branchesList = data?.split("\n") ?? [];
      branches = branchesList
        .map((branch) => branch.split("/")[1])
        .filter(Boolean);
    })
    .catch((error) => {
      console.error("Error fetching the list of branches:", error);
    });
}

async function fetchAllSpecs(branch) {
  const basePath = `${SPECS_URL}/swaggers/`;
  const url = `${SPECS_URL}/branches/${branch}/specs.json`;

  return fetch(url)
    .then((response) => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      return response.json();
    })
    .then((data) => {
      const specsData = data.map((spec) => {
        const specName = spec.substring(
          spec.lastIndexOf("/") + 1,
          spec.indexOf(".")
        );
        return {
          url: `${basePath}${branch}${spec}`,
          name: specName,
        };
      });

      specs = specsData;
    })
    .catch((error) => {
      console.error("Error fetching the list of specs:", error);
      return [];
    });
}

let branches = null;
let specs = null;

const SPECS_URL = localStorage.getItem("dev")
  ? "http://localhost:8080"
  : "https://swagger.deel.network";

window.onload = async () => {
  await fetchAllBranches();
  await fetchAllSpecs(getQueryParam("branch") || branches[0]);

  await initializeSwaggerWithCustomHeader();
  applyOptionsToBranchesSelect(branches);
};
