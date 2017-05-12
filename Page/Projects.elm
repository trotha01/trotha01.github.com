module Page.Projects exposing (Model, Msg, init, view, update)

import Css exposing (..)
import Html exposing (Html, button, div, text, a, p, ul, li)
import Html.Attributes
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
    div [] [ projects ]


projects : Html msg
projects =
    div
        [ styles
            [ padding (px 10)
            ]
        ]
        [ ul []
            [ li [] [ Html.text "Project 1" ] ]
        ]



-- STYLE


styles =
    (Css.asPairs >> Html.Attributes.style)
