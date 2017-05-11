module Page.Home exposing (Model, Msg, init, view, update)

import Css exposing (..)
import Html exposing (Html, button, div, text, a)
import Html.Attributes
import Route
import Page.Header as Header


-- MODEL


type alias Model =
    { header : Header.Model }


init : Model
init =
    { header = Header.init }



-- UPDATE


type Msg
    = HeaderMsg Header.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        HeaderMsg headerMsg ->
            { model | header = Header.update headerMsg model.header }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ -- Header.view model.header |> Html.map HeaderMsg
          home
        ]


home : Html msg
home =
    div
        [ styles
            [ padding (px 10)
            ]
        ]
        [ Html.text "Home"
        ]



-- STYLE


styles =
    (Css.asPairs >> Html.Attributes.style)
