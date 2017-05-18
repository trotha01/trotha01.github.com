module Page.Helper exposing (..)

import Html exposing (Html, div, img)
import Html.Attributes as Attr
import Css exposing (..)
import Window


topImageView : Window.Size -> Html msg -> Html msg -> Html msg
topImageView window topImage body =
    div
        [ styles
            [ width (px <| toFloat window.width)
            , height (px <| toFloat window.height)
            ]
        ]
        [ topImage, body ]


topImage : String -> List Css.Mixin -> Html a
topImage src background =
    div
        [ styles
            [ height (pct 50)
            ]
        ]
        [ img
            [ styles
                ([ height (pct 100)
                 , width (pct 100)
                 ]
                    ++ background
                )
            , Attr.src src
            ]
            []
        ]


styles =
    (Css.asPairs >> Attr.style)
