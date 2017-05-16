module Page.Contact exposing (Model, Msg, init, view, update)

import Css exposing (..)
import Html exposing (Html, button, div, text, a, p, ul, li, img)
import Html.Attributes as Attr
import Route
import Page.Header as Header
import Window


-- MODEL


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type Msg
    = HeaderMsg Header.Msg


update : Msg -> Model -> Model
update msg model =
    model



-- View


view : Window.Size -> Model -> Html Msg
view window model =
    div
        [ styles
            [ width (px <| toFloat window.width)
            , height (px <| toFloat window.height)
            ]
        ]
        [ topImage, contact ]


topImage : Html a
topImage =
    div
        [ styles
            [ width (pct 100)
            ]
        ]
        [ img
            [ styles
                [ width (pct 100)
                ]
            , Attr.src "imgs/mail.svg"
            ]
            []
        ]


contact : Html msg
contact =
    div
        [ styles
            [ padding (px 100)
            ]
        ]
        [ Html.text "How to reach me..."
        , ul []
            [ li [] [ Html.text "trotha01 at gmail" ]
            , li []
                [ Html.text "Or through "
                , a [ Attr.href "https://www.linkedin.com/in/trevorrothaus/" ] [ Html.text "LinkedIn" ]
                ]
            ]
        ]



-- STYLE


styles =
    (Css.asPairs >> Attr.style)
