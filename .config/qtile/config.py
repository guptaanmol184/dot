import os
import subprocess

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook

try:
    from typing import List  # noqa: F401
except ImportError:
    pass

mod = "mod4"
alt = 'mod1'
terminal = os.environ['TERMINAL']
browser = os.environ['BROWSER']

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),

    # Move windows up or down in current stack
    Key([mod, "control"], "k", lazy.layout.shuffle_down()),
    Key([mod, "control"], "j", lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod], "Return", lazy.spawn(terminal)),

    # Toggle between different layouts as defined below
    #Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "n", lazy.next_layout()),
    Key([mod, "shift"], "n", lazy.prev_layout()),
    Key([mod], "Tab", lazy.screen.toggle_group()),
    Key([mod], "q", lazy.window.kill()),

    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    #Key([mod], "r", lazy.spawncmd()),
    Key([mod], "d", lazy.spawn("rofi -modi run,window -terminal kitty -theme arthur -show run")),
    Key([mod], "w", lazy.spawn(browser)),
    Key([mod], "x", lazy.spawn("locker.sh")),
    Key([mod, "shift"], "x", lazy.spawn("xset dpms force off")),
    Key([mod], "e", lazy.spawn("thunar")),
    Key([mod], "f", lazy.window.toggle_floating()),

    # Volume
    Key([], 'XF86AudioRaiseVolume',
        lazy.spawn('''bash -c 'amixer -q set Master 2%+' ''')),
    Key([], 'XF86AudioLowerVolume',
        lazy.spawn('''bash -c 'amixer -q set Master 2%-' ''')),
    Key([], 'XF86AudioMute',
        lazy.spawn('''bash -c 'amixer -q set Master toggle' ''')),

    # Brightness
    Key([], 'XF86MonBrightnessDown',
        lazy.spawn('''bash -c 'lux -s3%' ''')),
    Key([], 'XF86MonBrightnessUp',
        lazy.spawn('''bash -c 'lux -a3%' ''')),

    # Misc
    Key([], 'Print',
        lazy.spawn('scrot -e \'mkdir -p ~/screenshots; mv $f ~/screenshots/\'')
        ),
]

groups = [Group(i) for i in "123456"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen()),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
    ])

# layouts = [
#     layout.Max(),
#     layout.Stack(num_stacks=2),
#     layout.Bsp(),
#     layout.Columns(),
#     layout.Floating(),
#     layout.Matrix(),
#     layout.MonadTall(),
#     layout.MonadWide(),
#     layout.RatioTile(),
#     layout.Slice(),
#     layout.Tile(),
#     layout.TreeTab(),
#     layout.VerticalTile(),
#     layout.Wmii(),
#     layout.Zoomy()
# ]

layouts = [
    layout.Max(),
    layout.Stack(num_stacks=2),
    layout.MonadTall(),
    # layout.Bsp(),
]

widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

#widget.Prompt(),
screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.TextBox(
                    font="Arial", foreground="#ffffff",background="222222",
                    # font="Arial", foreground=COLS["deus_3"],
                    text="◢", fontsize=50, padding=-1
                ),
                widget.GroupBox(
                    # other_current_screen_border=COLS["orange_0"],
                    # this_current_screen_border=COLS["blue_0"],
                    # this_current_screen_border=COLS["deus_2"],
                    # other_screen_border=COLS["orange_0"],
                    # this_screen_border=COLS["blue_0"],
                    # this_screen_border=COLS["deus_2"],
                    highlight_color="#888888",
                    # highlight_color=COLS["deus_2"],
                    # urgent_border=COLS["red_1"],
                    background="#222222",
                    # background=COLS["deus_3"],
                    highlight_method="line",
                    # inactive=COLS["dark_2"],
                    # active=COLS["light_2"],
                    # disable_drag=True,
                    borderwidth=2,
                ),
                widget.TextBox(
                    font="Arial", foreground="#ffffff",
                    # font="Arial", foreground=COLS["deus_3"],
                    text="◤ ", fontsize=50, padding=-5
                ),
                #widget.WindowName(),
                widget.TaskList(),
                #widget.WindowTabs(),
                widget.Sep(),

                widget.Systray(),
                widget.Sep(),

                widget.Battery(),
                widget.Sep(),

                widget.Pacman(),
                widget.Sep(),

                widget.Volume(),
                widget.Sep(),

                widget.CurrentLayoutIcon(),
                widget.CurrentLayout(),
                widget.Sep(),

                widget.Pomodoro(),
                widget.Sep(),

                widget.Memory(),
                widget.Sep(),
                # widget.Net('wlo1'),
                # widget.Net('eno1'),
                widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
            ],
            24,
            background = ["#000000", "#222222"]
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
    {'wmclass': 'nm-connection-editor'},  # nm-applet
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, github issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

# @hook.subscribe.startup_once
# def autostart():
#     processes = [
#         ['nm-applet'],
#         ['feh', '--bg-scale', '/home/ag/.config/qtile/wall'],
#         ['dunst'],
#         ['compton', '-c', '-b'],
#         ['redshift'],
#         ['rescuetime'],
#         ['unclutter'],
#         ['xautolock', '-time', '3', '-locker', 'i3lock-next']

#     ]

#     for p in processes:
#         subprocess.Popen(p)


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])
