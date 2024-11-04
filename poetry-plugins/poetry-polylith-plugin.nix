{ lib
, fetchFromGitHub
, poetry
, python3Packages
}:
python3Packages.buildPythonPackage rec {
  pname = "poetry-polylith-plugin";
  version = "stable-55";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "DavidVujic";
    repo = "python-polylith";
    rev = "refs/tags/${version}";
    hash = "sha256-awFpX8f1As/ICHRro6KgVf9GRiokg0MZgcifVIrg/Mk=";
  };

  nativeBuildInputs = [
    python3Packages.poetry-core
  ];

  nativeCheckInputs = [
    poetry
    python3Packages.pytestCheckHook
    python3Packages.platformdirs
    python3Packages.requests
    python3Packages.virtualenv
    python3Packages.cachecontrol
    python3Packages.pkginfo
    python3Packages.requests_toolbelt
    python3Packages.mypy-extensions
  ];

  dependencies = [
    python3Packages.cleo
    python3Packages.hatchling
    python3Packages.rich
    python3Packages.tomlkit
    python3Packages.typer
  ];

  disabledTests = [
    "test_distribution_package"
    "test_distributions"
  ];

  meta = with lib; {
    description = "Tooling support for the Polylith Architecture in Python.";
    homepage = "https://github.com/DavidVujic/python-polylith";
    license = licenses.mit;
  };
}
