module Main exposing (..)

import Css exposing (..)
import Html exposing (Html, button, text, div)
import Html.Attributes
import Html.Events exposing (onClick)
import Route exposing (Route)
import Page.Header as Header
import Util exposing ((=>))
import Page.Home as Home
import Page.About as About
import Page.Errored as Errored exposing (PageLoadError)
import Navigation exposing (Location)


main =
    Navigation.program (Route.fromLocation >> SetRoute)
        { init = init, update = update, view = view, subscriptions = subscriptions }



-- MODEL


type alias Model =
    { page : Page
    , header : Header.Model
    }


type Page
    = Home Home.Model
    | About About.Model


init : Location -> ( Model, Cmd Msg )
init location =
    setRoute
        (Route.fromLocation location)
        initialModel


initialModel =
    { page = Home Home.init
    , header = Header.init
    }



-- UPDATE


type Msg
    = SetRoute (Maybe Route)
    | HomeMsg Home.Msg
    | AboutMsg About.Msg
    | HeaderMsg Header.Msg


setRoute : Maybe Route -> Model -> ( Model, Cmd Msg )
setRoute maybeRoute model =
    case maybeRoute of
        Nothing ->
            ( model, Cmd.none )

        Just (Route.Home) ->
            ( { model | page = Home Home.init }, Cmd.none )

        Just (Route.About) ->
            ( { model | page = About About.init }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.page ) of
        ( SetRoute route, _ ) ->
            setRoute route model

        ( HomeMsg homeMsg, Home home ) ->
            ( { model | page = Home (Home.update homeMsg home) }, Cmd.none )

        ( AboutMsg aboutMsg, About about ) ->
            ( { model | page = About (About.update aboutMsg about) }, Cmd.none )

        ( HeaderMsg headerMsg, _ ) ->
            ( { model | header = (Header.update headerMsg model.header) }, Cmd.none )

        _ ->
            model => Cmd.none



-- VIEW


view : Model -> Html Msg
view model =
    let
        page =
            case model.page of
                Home subModel ->
                    Home.view subModel |> Html.map HomeMsg

                About subModel ->
                    About.view subModel |> Html.map AboutMsg
    in
        div []
            [ Header.view model.header |> Html.map HeaderMsg
            , div
                [ styles
                    [ property "background" "radial-gradient(black 15%, transparent 16%) 0 0, radial-gradient(black 15%, transparent 16%) 8px 8px, radial-gradient(rgba(255,255,255,.1) 15%, transparent 20%) 0 1px, radial-gradient(rgba(255,255,255,.1) 15%, transparent 20%) 8px 9px"
                    , property "background-color" "#282828"
                    , backgroundSize2 (px 16) (px 16)
                    , property "display" "flex"
                    , justifyContent center
                    , alignItems center
                    , height (px 500)
                    ]
                ]
                [ div
                    [ styles
                        [ backgroundColor (rgb 255 255 255)
                        , width (pct 80)
                        , height (px 500)
                        ]
                    ]
                    [ page ]
                ]
            ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- STYLE


styles =
    (Css.asPairs >> Html.Attributes.style)
