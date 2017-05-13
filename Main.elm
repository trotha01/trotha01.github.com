module Main exposing (..)

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


main =
    Navigation.program (Route.fromLocation >> SetRoute)
        { init = init, update = update, view = view, subscriptions = subscriptions }



-- MODEL


type alias Model =
    { page : Page
    , header : Header.Model
    , route : Route
    }


type Page
    = Home Home.Model
    | About About.Model
    | Projects Projects.Model
    | Resume Resume.Model
    | Contact Contact.Model


init : Location -> ( Model, Cmd Msg )
init location =
    setRoute
        (Route.fromLocation location)
        initialModel


initialModel =
    { page = Home Home.init
    , header = Header.init
    , route = Route.Home
    }



-- UPDATE


type Msg
    = SetRoute (Maybe Route)
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
            ( { model | route = Route.Home, page = Home Home.init }, Cmd.none )

        Just (Route.About) ->
            ( { model | route = Route.About, page = About About.init }, Cmd.none )

        Just (Route.Projects) ->
            ( { model | route = Route.Projects, page = Projects Projects.init }, Cmd.none )

        Just (Route.Resume) ->
            ( { model | route = Route.Resume, page = Resume Resume.init }, Cmd.none )

        Just (Route.Contact) ->
            ( { model | route = Route.Contact, page = Contact Contact.init }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        headerUpdate newHeader =
            { model | header = newHeader } => Cmd.none

        pageUpdate page update =
            { model | page = page update } => Cmd.none
    in
        case ( msg, model.page ) of
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
                    Home.view subModel |> Html.map HomeMsg

                About subModel ->
                    About.view subModel |> Html.map AboutMsg

                Projects subModel ->
                    Projects.view subModel |> Html.map ProjectsMsg

                Resume subModel ->
                    Resume.view subModel |> Html.map ResumeMsg

                Contact subModel ->
                    Contact.view subModel |> Html.map ContactMsg
    in
        div []
            [ -- , background
              div
                [ styles
                    [ -- property "background" "radial-gradient(black 15%, transparent 16%) 0 0, radial-gradient(black 15%, transparent 16%) 8px 8px, radial-gradient(rgba(255,255,255,.1) 15%, transparent 20%) 0 1px, radial-gradient(rgba(255,255,255,.1) 15%, transparent 20%) 8px 9px"
                      --  property "background-color" "#282828"
                      -- , backgroundSize2 (px 16) (px 16)
                      property "background-image" "url('imgs/giraffe.svg')"
                    , property "display" "flex"
                    , justifyContent center
                    , alignItems center
                    , height (px 500)
                    ]
                ]
                [ div
                    [ styles
                        [ backgroundColor (hsla 0 0 0.82 0.85)
                        , width (px 700)
                        , height (px 500)
                        ]
                    ]
                    [ Header.view model.route model.header |> Html.map HeaderMsg
                    , page
                    ]
                ]
            ]


background : Html a
background =
    img [ Attr.src "imgs/giraffe.svg" ] []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- STYLE


styles =
    (Css.asPairs >> Attr.style)
