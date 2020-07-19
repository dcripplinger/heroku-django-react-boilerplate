#!/bin/bash

NOCOLOR='\033[0m'
RED='\033[0;31m'
YELLOW='\033[1;33m'

RELOAD_BASHRC=false

echo "Checking pipenv..."
if ! [[ `which pipenv` ]]
then
    echo "No pipenv installation found on the system. Installing..."
    pip install pipenv
fi

echo "Checking pyenv..."
if ! [[ `which pyenv` ]]
then
    echo "No pyenv installation found on the system. Installing..."
    curl https://pyenv.run | bash
fi
if ! grep -q '^export PYENV_ROOT="\$HOME/\.pyenv"$' ~/.bashrc
then
    echo "Adding command \`export PYENV_ROOT=\"\$HOME/.pyenv\"\` to ~/.bashrc."
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
    RELOAD_BASHRC=true
fi
if ! grep -q '^export PATH="\$PYENV_ROOT/bin:\$PATH"$' ~/.bashrc
then
    echo "Adding command \`export PATH=\"\$PYENV_ROOT/bin:\$PATH\"\` to ~/.bashrc."
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
    RELOAD_BASHRC=true
fi

echo "Checking direnv..."
DIRENV_ALLOW=false
if ! [[ `which direnv` ]]
then
    echo "No direnv installation found on the system. Installing..."
    sudo apt install direnv
    DIRENV_ALLOW=true
fi
if ! grep -q 'direnv hook bash' ~/.bashrc
then
    echo "Adding command \`eval \"\$(direnv hook bash)\"\` to ~/.bashrc."
    echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
    RELOAD_BASHRC=true
    DIRENV_ALLOW=true
fi
if [ "$DIRENV_ALLOW" = true ]
then
    echo "Giving direnv permission to do its thing."
    direnv allow .
fi
if [ "$RELOAD_BASHRC" = true ]
then
    echo -e "${YELLOW}~/.bashrc has been modified. Please exit and restart the terminal for it to take effect, then re-run \`./setup.sh\`."
    exit 0
fi

echo "Checking python version..."
if [[ `pipenv check 2>&1 >/dev/null | grep 'Specifier python_full_version does not match'` ]]
then
    echo -e "${YELLOW}Wrong version of python installed in pipenv virtual environment. Removing the environment. Please exit this directory and return to it to trigger the environment to be created again. Then re-run \`./setup.sh\`."
    pipenv --rm
    exit 0
fi

echo "Installing any missing dependencies..."
pipenv install --dev

echo "Applying any database migrations..."
./manage.py migrate
