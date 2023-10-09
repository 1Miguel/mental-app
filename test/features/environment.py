"""Behave Test Environment Setup.

date: 08/10/2023
"""

from behave.runner import Context

def before_step(context: Context, step) -> None:
    pass

def after_step(context: Context, step) -> None:
    pass

def before_scenario(context: Context, scenario) -> None:
    pass

def after_scenario(context: Context, scenario) -> None:
    pass

def before_feature(context: Context, feature) -> None:
    pass

def after_feature(context: Context, feature) -> None:
    pass

def before_tag(context: Context, tag) -> None:
    pass

def after_tag(context: Context, tag) -> None:
    pass

def before_all(context: Context) -> None:
    pass
    # context.config.setup_logging(configfile="behave.ini", filename="test.log")

def after_all(context) -> None:
    pass
