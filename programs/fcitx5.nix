{ ... }:
{
  # fcitx5 profile
  # xdg.configFile."fcitx5/profile".text = ''
  #   [Groups/0]
  #   # Group Name
  #   Name=Default
  #   # Layout
  #   Default Layout=us
  #   # Default Input Method
  #   DefaultIM=rime

  #   [Groups/0/Items/0]
  #   # Name
  #   Name=keyboard-us
  #   # Layout
  #   Layout=

  #   [Groups/0/Items/1]
  #   # Name
  #   Name=rime
  #   # Layout
  #   Layout=

  #   [GroupOrder]
  #   0=Default
  # '';
  # fcitx5 config
  xdg.configFile."fcitx5/config".text = ''
    [Hotkey]
    # Enumerate when press trigger key repeatedly
    EnumerateWithTriggerKeys=True
    # Temporally switch between first and current Input Method
    AltTriggerKeys=
    # Enumerate Input Method Forward
    EnumerateForwardKeys=
    # Enumerate Input Method Backward
    EnumerateBackwardKeys=
    # Skip first input method while enumerating
    EnumerateSkipFirst=False
    # Toggle embedded preedit
    TogglePreedit=

    [Hotkey/TriggerKeys]
    0=Control+space

    [Hotkey/EnumerateGroupForwardKeys]
    0=Super+space

    [Hotkey/EnumerateGroupBackwardKeys]
    0=Shift+Super+space

    [Hotkey/ActivateKeys]
    0=Hangul_Hanja

    [Hotkey/DeactivateKeys]
    0=Hangul_Romaja

    [Hotkey/PrevPage]
    1=minus

    [Hotkey/NextPage]
    1=equal

    [Hotkey/NextCandidate]
    0=Tab

    [Behavior]
    # Active By Default
    ActiveByDefault=False
    # Reset state on Focus In
    resetStateWhenFocusIn=No
    # Share Input State
    ShareInputState=Program
    # Show preedit in application
    PreeditEnabledByDefault=True
    # Show Input Method Information when switch input method
    ShowInputMethodInformation=True
    # Show Input Method Information when changing focus
    showInputMethodInformationWhenFocusIn=False
    # Show compact input method information
    CompactInputMethodInformation=True
    # Show first input method information
    ShowFirstInputMethodInformation=False
    # Default page size
    DefaultPageSize=7
    # Override Xkb Option
    OverrideXkbOption=False
    # Custom Xkb Option
    CustomXkbOption=
    # Force Enabled Addons
    EnabledAddons=
    # Force Disabled Addons
    DisabledAddons=
    # Preload input method to be used by default
    PreloadInputMethod=True
    # Allow input method in the password field
    AllowInputMethodForPassword=False
    # Show preedit text when typing password
    ShowPreeditForPassword=False
    # Interval of saving user data in minutes
    AutoSavePeriod=30
  '';

  xdg.configFile."fcitx5/conf/classicui.conf".text = ''
    # 垂直候选列表
    Vertical Candidate List=False
    # 使用鼠标滚轮翻页
    WheelForPaging=True
    # 字体
    Font="Sans 10"
    # 菜单字体
    MenuFont="Sans 10"
    # 托盘字体
    TrayFont="Sans Bold 10"
    # 托盘标签轮廓颜色
    TrayOutlineColor=#000000
    # 托盘标签文本颜色
    TrayTextColor=#ffffff
    # 优先使用文字图标
    PreferTextIcon=False
    # 在图标中显示布局名称
    ShowLayoutNameInIcon=True
    # 使用输入法的语言来显示文字
    UseInputMethodLanguageToDisplayText=True
    # 主题
    Theme=default
    # 深色主题
    DarkTheme=default-dark
    # 跟随系统浅色/深色设置
    UseDarkTheme=true
    # 当被主题和桌面支持时使用系统的重点色
    UseAccentColor=True
    # 在 X11 上针对不同屏幕使用单独的 DPI
    PerScreenDPI=False
    # 固定 Wayland 的字体 DPI
    ForceWaylandDPI=0
    # 在 Wayland 下启用分数缩放
    EnableFractionalScale=True
  '';

  # fcitx5-rime custom config
  # TODO: remove all the other files under ~/.local/share/fcitx5/rime, if rime did not correctly build.
  # home.file.".local/share/fcitx5/rime/default.custom.yaml".text = ''
  #   patch:
  #     schema_list:
  #       - schema: "rime_ice"
  #     menu/page_size: 9
  #     key_binder:
  #       bindings:
  #         - { when: paging, accept: comma, send: Page_Up }
  #         - { when: has_menu, accept: period, send: Page_Down }
  # '';
}
