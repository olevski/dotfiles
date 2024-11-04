{ lib, pkgs, ... }:

pkgs.python3Packages.buildPythonPackage rec {
  pname = "poetry-polylith-plugin";
  version = "stable-55";
  format = "pyproject";

  src = pkgs.fetchFromGitHub {
    owner = "DavidVujic";
    repo = "python-polylith";
    rev = "refs/tags/${version}";
    hash = "sha256-awFpX8f1As/ICHRro6KgVf9GRiokg0MZgcifVIrg/Mk=";
  };

  nativeBuildInputs = [
    pkgs.python3Packages.poetry-core
  ];

  nativeCheckInputs = [
    pkgs.poetry
    pkgs.python3Packages.pytestCheckHook
    pkgs.python3Packages.platformdirs
    pkgs.python3Packages.requests
    pkgs.python3Packages.virtualenv
    pkgs.python3Packages.cachecontrol
    pkgs.python3Packages.pkginfo
    pkgs.python3Packages.requests_toolbelt
    pkgs.python3Packages.mypy-extensions
  ];

  dependencies = [
    pkgs.python3Packages.cleo
    pkgs.python3Packages.hatchling
    pkgs.python3Packages.rich
    pkgs.python3Packages.tomlkit
    pkgs.python3Packages.typer
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
