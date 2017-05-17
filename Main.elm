port module Main exposing (..)

import Css exposing (..)
import Html exposing (Html, button, text, div, img)
import Html.Attributes as Attr
import Html.Events exposing (onClick)
import Route exposing (Route)
import Page.Header as Header
import Util exposing ((=>))
import Page.Home as Home
import Page.About as About
import Page.Projects as Projects
import Page.Resume as Resume
import Page.Contact as Contact
import Page.Errored as Errored exposing (PageLoadError)
import Navigation exposing (Location)
import Window
import Task


main =
    Navigation.program (Route.fromLocation >> SetRoute)
        { init = init, update = update, view = view, subscriptions = subscriptions }



-- MODEL


type alias Model =
    { page : Page
    , header : Header.Model
    , route : Route
    , window : Window.Size
    }


type Page
    = Home Home.Model
    | About About.Model
    | Projects Projects.Model
    | Resume Resume.Model
    | Contact Contact.Model


init : Location -> ( Model, Cmd Msg )
init location =
    let
        ( newModel, cmd ) =
            setRoute (Route.fromLocation location) initialModel

        windowSizeCmd =
            Task.perform WindowResize Window.size
    in
        newModel => Cmd.batch [ cmd, windowSizeCmd ]


initialModel =
    { page = Home Home.init
    , header = Header.init
    , route = Route.Home
    , window = { width = 0, height = 0 }
    }



-- UPDATE


type Msg
    = SetRoute (Maybe Route)
    | WindowResize Window.Size
    | HomeMsg Home.Msg
    | AboutMsg About.Msg
    | ProjectsMsg Projects.Msg
    | ResumeMsg Resume.Msg
    | ContactMsg Contact.Msg
    | HeaderMsg Header.Msg


setRoute : Maybe Route -> Model -> ( Model, Cmd Msg )
setRoute maybeRoute model =
    case maybeRoute of
        Nothing ->
            ( model, Cmd.none )

        Just (Route.Home) ->
            { model | route = Route.Home, page = Home Home.init }
                => setPage ""

        Just (Route.About) ->
            { model | route = Route.About, page = About About.init }
                => setPage (Route.toString Route.About)

        Just (Route.Projects) ->
            { model | route = Route.Projects, page = Projects Projects.init }
                => setPage (Route.toString Route.Projects)

        Just (Route.Resume) ->
            { model | route = Route.Resume, page = Resume Resume.init }
                => setPage (Route.toString Route.Resume)

        Just (Route.Contact) ->
            { model | route = Route.Contact, page = Contact Contact.init }
                => setPage (Route.toString Route.Contact)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        headerUpdate newHeader =
            { model | header = newHeader } => Cmd.none

        pageUpdate page update =
            { model | page = page update } => Cmd.none
    in
        case ( msg, model.page ) of
            ( WindowResize size, _ ) ->
                { model | window = size } => Cmd.none

            ( SetRoute route, _ ) ->
                setRoute route model

            ( HomeMsg homeMsg, Home home ) ->
                pageUpdate Home (Home.update homeMsg home)

            ( AboutMsg aboutMsg, About about ) ->
                pageUpdate About (About.update aboutMsg about)

            ( ProjectsMsg aboutMsg, Projects about ) ->
                pageUpdate Projects (Projects.update aboutMsg about)

            ( ResumeMsg aboutMsg, Resume about ) ->
                pageUpdate Resume (Resume.update aboutMsg about)

            ( ContactMsg aboutMsg, Contact about ) ->
                pageUpdate Contact (Contact.update aboutMsg about)

            ( HeaderMsg headerMsg, _ ) ->
                headerUpdate (Header.update headerMsg model.header)

            _ ->
                model => Cmd.none



-- VIEW


view : Model -> Html Msg
view model =
    let
        page =
            case model.page of
                Home subModel ->
                    Home.view model.window subModel |> Html.map HomeMsg

                About subModel ->
                    About.view model.window subModel |> Html.map AboutMsg

                Projects subModel ->
                    Projects.view model.window subModel |> Html.map ProjectsMsg

                Resume subModel ->
                    Resume.view model.window subModel |> Html.map ResumeMsg

                Contact subModel ->
                    Contact.view model.window subModel |> Html.map ContactMsg
    in
        div
            [ styles
                [ backgroundColor (hsla 0 0 1 0.85)
                , width (px <| toFloat model.window.width)
                , height (px <| toFloat (model.window.height - Header.tallness))
                ]
            ]
            [ Header.view model.route model.header |> Html.map HeaderMsg
            , page
            ]


background : Html a
background =
    img [ Attr.src "imgs/giraffe.svg" ] []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Window.resizes WindowResize



-- PORTS


port setPage : String -> Cmd msg



-- STYLE


styles =
    (Css.asPairs >> Attr.style)
