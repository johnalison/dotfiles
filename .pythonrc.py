try:
    import readline
    print("Imported readline")
except ImportError:
    print("Module readline not available.")
else:
    import rlcompleter
    readline.parse_and_bind("tab: complete")
    print("Imported rlcompleter")
    #readline support, if available


print("Ran: ~/.pythonrc.py")
#from inQuad import inQuad
#from sci    import sci

import atexit
import os.path


#
# Old
#
####try:
####    import readline
####except ImportError:
####    print("Failed to import readline")
####    pass
####else:
####    import rlcompleter
####
####    class IrlCompleter(rlcompleter.Completer):
####        """
####        This class enables a "tab" insertion if there's no text for
####        completion.
####
####        The default "tab" is four spaces. You can initialize with '\t' as
####        the tab if you wish to use a genuine tab.
####
####        """
####
####        def __init__(self, tab='    '):
####            self.tab = tab
####            rlcompleter.Completer.__init__(self)
####
####
####        def complete(self, text, state):
####            if text == '':
####                readline.insert_text(self.tab)
####                return None
####            else:
####                return rlcompleter.Completer.complete(self,text,state)
####
####
####    #you could change this line to bind another key instead tab.
####    #readline.parse_and_bind ("bind ^I rl_complete")
####
####    ##readline.parse_and_bind('tab: complete')
####    readline.set_completer(IrlCompleter('\t').complete)


try:
    import readline
except ImportError:
    print( "Module readline not available.")
else:
    import rlcompleter
    if 'libedit' in readline.__doc__:
        readline.parse_and_bind("bind ^I rl_complete")
    else:
        readline.parse_and_bind("tab: complete")


# Restore our command-line history, and save it when Python exits.
history_path = os.path.expanduser('~/pyhistory')
if os.path.isfile(history_path):
    print("History file is",history_path)
    readline.read_history_file(str(history_path))
atexit.register(lambda x=history_path: readline.write_history_file(x))


#
# Before
#

#### system and interpreter setup ------------------------------------------------
#import os, sys, time
#import string as pystring
#
### there's no version_info in 1.5.2
#if sys.version[0:3] < '2.2':
#    raise ImportError, 'Python Version 2.2 or above is required.'
#
### 2.2 has 10 instructions as default, > 2.3 has 100 ... make same
#sys.setcheckinterval( 100 )
#
#try:
#   import rlcompleter, readline
#
#   class FileNameCompleter( rlcompleter.Completer ):
#      def file_matches( self, text ):
#         matches = []
#         path, name = os.path.split( text )
#
#         try:
#            for fn in os.listdir( path or os.curdir ):
#               if fn[:len(name)] == name:
#                  full = os.path.join( path, fn )
#                  matches.append( full )
#
#                  if os.path.isdir( full ):
#                     matches += map( lambda x: os.path.join( full, x ), os.listdir( full ) )
#         except OSError:
#            print "ERROR"
#            pass
#
#         return matches
#
#      def global_matches( self, text ):
#         matches = rlcompleter.Completer.global_matches( self, text )
#         if not matches:
#            matches = []
#         return matches + self.file_matches( text )
#
#   readline.set_completer( FileNameCompleter().complete )
#   readline.set_completer_delims(
#      pystring.replace( readline.get_completer_delims(), os.sep , '' ) )
#
#   readline.parse_and_bind( 'tab: complete' )
#   readline.parse_and_bind( 'set show-all-if-ambiguous On' )
#
#except:
#    # module readline typically doesn't exist on non-Unix platforms
#    print "eror gettign tab complete!"
#    pass
#
####---------------The following is to get the history
#
#import atexit
#import os
#
#historyPath = os.path.expanduser("~/.pyhistory")
#
#try:
#    import readline
#except ImportError:
#    print "Module readline not available."
#else:
#    import rlcompleter
#    readline.parse_and_bind("tab: complete")
#    if os.path.exists(historyPath):
#        readline.read_history_file(historyPath)
#
#def save_history(historyPath=historyPath):
#    try:
#        import readline
#    except ImportError:
#        print "Module readline not available."
#    else:
#        readline.write_history_file(historyPath)
#atexit.register(save_history)
#
