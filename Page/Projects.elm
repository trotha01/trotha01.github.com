module Page.Projects exposing (Model, Msg, init, view, update)

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
    div [] [ projects ]



{-
   - TODO: update to projects and ideas
-}


projects : Html msg
projects =
    div
        [ styles
            [ padding (px 10)
            ]
        ]
        [ ul []
            [ project "Boxes and Bubbles (built on top of jastice's library)" "https://github.com/trotha01/boxes-and-bubbles"
            , project "Bee Game" "https://github.com/trotha01/bee"
            , project "Treadmill" "https://github.com/trotha01/treadmill"
            ]
        ]


project : String -> String -> Html msg
project title href =
    li [] [ a [ Attr.href href ] [ Html.text title ] ]



-- STYLE


styles =
    (Css.asPairs >> Attr.style)
