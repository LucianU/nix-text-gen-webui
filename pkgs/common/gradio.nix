{ lib
, callPackage
, buildPythonPackage
, fetchFromGitHub
, hatch-fancy-pypi-readme
, hatch-requirements-txt
, hatchling
, aiofiles
, aiohttp
, altair
, fastapi
, httpx
, huggingface-hub
, jinja2
, markdown-it-py
, markupsafe
, matplotlib
, mdit-py-plugins
, numpy
, orjson
, pandas
, pillow
, pydantic
, pydub
, pygments
, python-multipart
, pyyaml
, requests
, semantic-version
, uvicorn
, websockets
}:
let
  ffmpy = callPackage ./ffmpy.nix { };
in

buildPythonPackage rec {
  pname = "gradio";
  version = "3.35.2";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "gradio-app";
    repo = "gradio";
    rev = "v${version}";
    hash = "sha256-ZmflnAGP0iWvwIsi/B2bUNCsaPjYY91V3Lsp62pRdL4=";
  };

  nativeBuildInputs = [
    hatch-fancy-pypi-readme
    hatch-requirements-txt
    hatchling
  ];

  propagatedBuildInputs = [
    aiofiles
    aiohttp
    altair
    fastapi
    ffmpy
    httpx
    huggingface-hub
    jinja2
    markdown-it-py
    markupsafe
    matplotlib
    mdit-py-plugins
    numpy
    orjson
    pandas
    pillow
    pydantic
    pydub
    pygments
    python-multipart
    pyyaml
    requests
    semantic-version
    uvicorn
    websockets
  ];

  pythonImportsCheck = [ "gradio" ];

  meta = with lib; {
    description = "Create UIs for your machine learning model in Python in 3 minutes";
    homepage = "https://github.com/gradio-app/gradio";
    changelog = "https://github.com/gradio-app/gradio/blob/${src.rev}/CHANGELOG.md";
    license = licenses.asl20;
    maintainers = with maintainers; [ ];
  };
}
