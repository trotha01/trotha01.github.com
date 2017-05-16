module Page.Projects exposing (Model, Msg, init, view, update)

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
    div [] [ topImage, projects ]


topImage : Html a
topImage =
    div
        [ styles
            [ height (pct 100)
            , width (pct 100)
            ]
        ]
        [ img
            [ styles
                [ height (pct 100)
                , width (pct 100)
                , property "background" "radial-gradient(black 15%, transparent 16%) 0 0, radial-gradient(black 15%, transparent 16%) 8px 8px, radial-gradient(rgba(255,255,255,.1) 15%, transparent 20%) 0 1px, radial-gradient(rgba(255,255,255,.1) 15%, transparent 20%) 8px 9px"
                , property "backgroundColor" "#282828"
                , property "backgroundSize" "16px 16px"
                ]
            , Attr.src "imgs/tools.svg"
            ]
            []
        ]



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
