module Page.Home exposing (Model, Msg, init, view, update)

import Css exposing (..)
import Html exposing (Html, button, div, text, a, img)
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



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ home ]


home : Html msg
home =
    div
        [ styles
            [ padding (px 10)
            ]
        ]
        [ profilePic
        , description
        ]


profilePic : Html msg
profilePic =
    img
        [ styles
            [ width (px 100)
            , height (px 100)
            , borderRadius (px 250)
            ]
        , Attr.src "imgs/profile.jpg"
        ]
        []


description : Html msg
description =
    div []
        [ Html.text "Welcome to my website! If you enjoy education or educational games, please reach out to me! I love talking with new people."
        ]



-- STYLE


styles =
    (Css.asPairs >> Attr.style)
