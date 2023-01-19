import atexit
import readline
import os

histfile = os.path.join(os.path.expanduser('~/.local/state/'), '.python_history')

try:
    readline.read_history_file(histfile)
    readline.set_history_length(1000)
except FileNotFoundError:
    pass

atexit.register(readline.write_history_file, histfile)
