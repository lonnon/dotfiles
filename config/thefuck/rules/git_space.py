import re

from thefuck.specific.git import git_support


@git_support
def match(command):
    return (
        'command not found: gi' in command.output
        and re.match('gi t(.+)', command.script)
    )


@git_support
def get_new_command(command):
    args = re.search('gi t(.+)', command.script).group(1)
    return 'git {}'.format(args)


enabled_by_default = True
priority = 1000
requires_output = True
