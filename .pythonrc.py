try:
    import readline
    import sys
except ImportError:
    print "Module not available."
else:
    import rlcompleter
    readline.parse_and_bind("tab: complete")

h = [None]  # history

class Prompt:
    """A prompt a history mechanism.
    From http://www.norvig.com/python-iaq.html
    """
    def __init__(self, prompt='h[%d] >>> '):
        self.prompt = prompt

    def __str__(self):
        try:
            if _ not in h: h.append(_)
        except NameError:
            pass
        return self.prompt % len(h)

    def __radd__(self, other):
        return str(other) + str(self)

sys.ps1 = Prompt()
sys.ps2 = '     ... '
