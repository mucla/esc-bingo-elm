module Styles exposing (..)

import Html exposing (Html, button, div, text, ul, li, a)
import Html.Events exposing (onClick, targetValue, onInput)
import Html.Attributes as At exposing (..)

-- STYLES

navStyle : List (Html.Attribute msg)
navStyle = [style "height" "100%"
          , style "width" "200px"
          , style "position" "fixed"
          , style "z-index" "1"
          , style "top" "0"
          , style "left" "0"
          , style "background-color" "#111"
          , style "overflow-x" "hidden"
          , style "padding-top" "20px"
          , style "color" "#818181"]


naviTextStyle : List (Html.Attribute msg)
naviTextStyle = [ style "padding" "6px 8px 6px 16px"
            , style "color" "#818181"
            , style "display" "block"
            , style "hover" " #f1f1f1" ]

separateNaviTextStyle : List (Html.Attribute msg)
separateNaviTextStyle = [ style "padding" "10px 20px"
            , style "border-top" "1px solid white"
            , style "display" "block"
            , style "margin-top" "20px" ]

naviLinkStyle : List (Html.Attribute msg)
naviLinkStyle = naviTextStyle ++ [style "text-decoration" "dotted underline"]

naviTitleStyle : List (Html.Attribute msg)
naviTitleStyle = [ style "padding" "6px 8px 6px 16px"
             , style "text-decoration" "none"
             , style "color" "#818181"
             , style "display" "block"
             , style "font-size" "25px"]

headingStyle : List (Html.Attribute msg)
headingStyle = [ style "text-decoration" "none"
               , style "display" "block"
               , style "font-size" "25px"]

contentStyle : List (Html.Attribute msg)
contentStyle = [style "margin-left" "200px"
              , style "padding" "6px 8px 6px 16px" ]


boxStyle : List (Html.Attribute msg)
boxStyle = [style "width" "450px"
           , style "text-align" "center"
           , style "border" "1px solid black"
           , style "border-radius" "5px"
           , style "padding" "4px"
           , style "align" "center"
           , style "background-color" "#d8d1bc"
           , style "margin-bottom" "0.5rem"
           ]

divStyle : List (Html.Attribute msg)
divStyle =
    [style "padding" "5px"]

sqrStyle : List (Html.Attribute msg)
sqrStyle =
    [ style "border" "1px solid black"
    , style "width" "100px"
    , style "height" "100px"
    ]

-- other possibly useable styles

textBoxStyle : List (Html.Attribute msg)
textBoxStyle = [ style "width" "350px"
               , style "height" "10px"
               , style "border-bottom-style" "dotted"
               , style "padding" "6px"
               , style "text-align" "center"
               , style "align" "center"
               ]

expressionStyle : List (Html.Attribute msg)
expressionStyle = [ style "height" "20px"
                  , style "padding" "20px"
                  , style "text-align" "center"
                  , style "align" "center"
                  ]

buttonStyle : List (Html.Attribute msg)
buttonStyle = [style "text-align" "center"
              , style "align" "center"]
