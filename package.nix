{ lib
, python3
, fetchFromGitHub
}:
let
  gradio = python3.pkgs.callPackage ./gradio.nix { };
  flexgen = python3.pkgs.callPackage ./flexgen.nix { };
  peft = python3.pkgs.callPackage ./peft.nix { };
in
python3.pkgs.buildPythonApplication rec {
  pname = "text-generation-webui";
  version = "installers";

  src = fetchFromGitHub {
    owner = "oobabooga";
    repo = "text-generation-webui";
    rev = version;
    hash = "sha256-18+Ed2+oNsPDT9VZgCCpXFW9TEokhJpoQzTVllCS7Jw=";
  };

  propagatedBuildInputs = with python3.pkgs; [
    accelerate
    colorama
    datasets
    einops
    flexgen
    markdown
    numpy
    pandas
    pillow
    pyyaml
    requests
    safetensors
    sentencepiece
    tqdm
    scipy
    transformers
    peft
    bitsandbytes
    llama-cpp-python
    gradio
  ];

  meta = with lib; {
    description = "A gradio web UI for running Large Language Models like LLaMA, llama.cpp, GPT-J, Pythia, OPT, and GALACTICA";
    homepage = "https://github.com/oobabooga/text-generation-webui";
    license = licenses.agpl3Only;
    maintainers = with maintainers; [ ];
  };
}
