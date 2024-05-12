{ config, inputs, lib, mkDisableOption, ... }:

{
  options.nixColorsAdapters.rofi = {
    enable = mkDisableOption "rofi";
  };

  config = lib.mkIf config.nixColorsAdapters.rofi.enable {
    programs.rofi.theme = "${config.xdg.configHome}/rofi/home-manager.config";

    # https://github.com/tinted-theming
    home.file."${config.xdg.configHome}/rofi/home-manager.config".text =
      with config.colorScheme.colors;
      let
        joinIntArray = intArray:
          lib.concatStringsSep "," (lib.forEach intArray (x: toString x));
        toRgbList = hexColor:
          joinIntArray (inputs.nix-colors.lib.conversions.hexToRGB hexColor);
      in
      ''
        * {
            red:                         rgba ( ${toRgbList base08}, 100 % );
            blue:                        rgba ( ${toRgbList base0D}, 100 % );
            lightfg:                     rgba ( ${toRgbList base06}, 100 % );
            lightbg:                     rgba ( ${toRgbList base01}, 100 % );
            foreground:                  rgba ( ${toRgbList base05}, 100 % );
            background:                  rgba ( ${toRgbList base00}, 100 % );
            background-color:            rgba ( ${toRgbList base00}, 0 % );
            separatorcolor:              @foreground;
            border-color:                @foreground;
            selected-normal-foreground:  @lightbg;
            selected-normal-background:  @lightfg;
            selected-active-foreground:  @background;
            selected-active-background:  @blue;
            selected-urgent-foreground:  @background;
            selected-urgent-background:  @red;
            normal-foreground:           @foreground;
            normal-background:           @background;
            active-foreground:           @blue;
            active-background:           @background;
            urgent-foreground:           @red;
            urgent-background:           @background;
            alternate-normal-foreground: @foreground;
            alternate-normal-background: @lightbg;
            alternate-active-foreground: @blue;
            alternate-active-background: @lightbg;
            alternate-urgent-foreground: @red;
            alternate-urgent-background: @lightbg;
            spacing:                     2;
        }
        window {
            background-color: @background;
            border:           1;
            padding:          5;
        }
        mainbox {
            border:           0;
            padding:          0;
        }
        message {
            border:           1px dash 0px 0px ;
            border-color:     @separatorcolor;
            padding:          1px ;
        }
        textbox {
            text-color:       @foreground;
        }
        listview {
            fixed-height:     0;
            border:           2px dash 0px 0px ;
            border-color:     @separatorcolor;
            spacing:          2px ;
            scrollbar:        true;
            padding:          2px 0px 0px ;
        }
        element-text, element-icon {
            background-color: inherit;
            text-color:       inherit;
        }
        element {
            border:           0;
            padding:          1px ;
        }
        element normal.normal {
            background-color: @normal-background;
            text-color:       @normal-foreground;
        }
        element normal.urgent {
            background-color: @urgent-background;
            text-color:       @urgent-foreground;
        }
        element normal.active {
            background-color: @active-background;
            text-color:       @active-foreground;
        }
        element selected.normal {
            background-color: @selected-normal-background;
            text-color:       @selected-normal-foreground;
        }
        element selected.urgent {
            background-color: @selected-urgent-background;
            text-color:       @selected-urgent-foreground;
        }
        element selected.active {
            background-color: @selected-active-background;
            text-color:       @selected-active-foreground;
        }
        element alternate.normal {
            background-color: @alternate-normal-background;
            text-color:       @alternate-normal-foreground;
        }
        element alternate.urgent {
            background-color: @alternate-urgent-background;
            text-color:       @alternate-urgent-foreground;
        }
        element alternate.active {
            background-color: @alternate-active-background;
            text-color:       @alternate-active-foreground;
        }
        scrollbar {
            width:            4px ;
            border:           0;
            handle-color:     @normal-foreground;
            handle-width:     8px ;
            padding:          0;
        }
        sidebar {
            border:           2px dash 0px 0px ;
            border-color:     @separatorcolor;
        }
        button {
            spacing:          0;
            text-color:       @normal-foreground;
        }
        button selected {
            background-color: @selected-normal-background;
            text-color:       @selected-normal-foreground;
        }
        inputbar {
            spacing:          0px;
            text-color:       @normal-foreground;
            padding:          1px ;
            children:         [ prompt,textbox-prompt-colon,entry,case-indicator ];
        }
        case-indicator {
            spacing:          0;
            text-color:       @normal-foreground;
        }
        entry {
            spacing:          0;
            text-color:       @normal-foreground;
        }
        prompt {
            spacing:          0;
            text-color:       @normal-foreground;
        }
        textbox-prompt-colon {
            expand:           false;
            str:              ":";
            margin:           0px 0.3000em 0.0000em 0.0000em ;
            text-color:       inherit;
        }
      '';
  };
}
