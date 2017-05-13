module Page.Contact exposing (Model, Msg, init, view, update)

import Css exposing (..)
import Html exposing (Html, button, div, text, a, p, ul, li)
import Html.Attributes as Attr
import Route
import Page.Header as Header


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


view : Model -> Html Msg
view model =
    div [] [ contact ]


contact : Html msg
contact =
    div
        [ styles
            [ padding (px 10)
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
