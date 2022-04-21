# kicad-template

This repository can be used as a template for a new KiCad project.

__Features:__  
- `kicad-library` submodule included and set up for sharing custom footprints, symbols, etc.
- GitHub workflows using kibot for outputs (gerbers, pdfs, renders, etc.) and performing checks (erc, drc)
- `bootstrap.sh` script for quickly renaming your project (no need for importing this as an "OEM - KiCad Template")
- `.gitattributes` and `.gitignore` for KiCad


## Getting Started
1. Create and clone a new GitHub repo for your project and select this as the template for it.
     ```bash
     gh repo create --clone --template krsche/kicad-template YOUR_REPO_NAME
     ```
2. Run the `bootstrap.sh` script to change the name of the project files and references to your projects name. 
     Either specify the name by providing it as the first argument, or specify nothing and it will use the parent folder (repo) name.
     ```bash
     ./bootstrap.sh <OPTIONAL__PROJECT_NAME>
     ```
3. Commit the changes after running the `bootstrap.sh` script
     ```bash
     git add --all
     git commit -m "feat: changed file names and refs to prj name"
     git push
     ```
4. Change the `README.md` and enjoy KiCad w/ GitHub :)

## Releasing
1. Observe the GH Actions already run on the commit you want to release.
     Everything looks good? --> Continue
2. Tag the commit in the format `v1.0.0` and push the tag
3. Observe the new GH Action that runs. It will re-run the KiBot actions and create a new GH Release with the outputs from KiBot.
