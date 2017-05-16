module Page.About exposing (Model, Msg, init, view, update)

import Css exposing (..)
import Html exposing (Html, button, div, text, a, img)
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
        [ topImage, about ]


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
                , property "background" "radial-gradient(circle, transparent 20%, slategray 20%, slategray 80%, transparent 80%, transparent), radial-gradient(circle, transparent 20%, slategray 20%, slategray 80%, transparent 80%, transparent) 50px 50px, linear-gradient(#A8B1BB 8px, transparent 8px) 0 -4px, linear-gradient(90deg, #A8B1BB 8px, transparent 8px) -4px 0"
                , property "backgroundColor" "slategray"
                , property "backgroundSize" "100px 100px, 100px 100px, 50px 50px, 50px 50px"
                ]
            , Attr.src "imgs/notebook.svg"
            ]
            []
        ]



{-
         p [] [ Html.text "As a pedagogy enthusiast, I understand the best way to learn is not through lectures and not through reading a book, but through interactivity. So I my dream is to design and create educational games." ]


      Act 1
      (once upon a time)
      - Grew up in So Cal
      I grew up in Sunny Southern California. I love going to the beach, I love the heat, and I love being with family and friends.

      (every day - learn how the world works)
      - Went to school
      - Enjoyed sharing knowledge
      Like most kids in the U.S., I went to school on the usual five day a week track for many years. I always enjoyed learning something new. Even more than that, I loved sharing that new piece of knowledge with those around me. If I learned something new at school, I would share it at home. If I learned something new at home, I would share it at school.

      (until one day - inciting incident)
      - School became boring and tedious
      Slowly, school became less interesting to me. I was starting to do more tedius tasks. I didn't feel like I was learning as much anymore. The joy I had faded. I knew there had to be a better way to teach. I knew there had to be a better way to learn. I was going to figure out that way.

      Act 2
      (because of this)
      From this, I grew a strong desire to improve education. Continuing through schooling, that desire only became stronger.
      (because of this)
      When I went to college, I discovered Computer Science. This was it! This was the way I could help improve education; through this platform. My first few ideas included creating an educational website filled with educational material. I had a problem though. From elementary school through college, I was fortunate enough to have amazing Mathematics teachers and I absolutely love Math! When in college, I knew I had to make the touch decision between following my own enjoyment, Mathematics, or pursuing a dream to improve education through Computer Science
      (because of this)
      - I choose computer science as a major.
      - I still need industry experience if I want to make something (or research comp sci/edu)
      I chose computer science as a major.

      (because of this)
      - I get a full time job in software
      From this, I was lucky enough to get into the software industry straight out of college.

      (because of this)
      - After a few years in the software industry, I do not feel very close to my education goal.

      (because of this - Low Point)
      - I am hopeless to completing an eductional game
      I spend all the free time I have working towards my education passion in the best way I know how. But I do not know if I am spending enough time learning game programming, if I am spending enough time reaching out to educators to network, or if I am spending enough time researching educational methods, or if I am spending enough time researching what games are already out there. I feel there is not enough time to do all the things I need to do.

      Act 3
      (until finally)
      - My Fiancée helps me plan.
      I have to give credit to my fiancée here. She is an aerialist pursuing her passion in the circus world. She got me a passion planner and gives me continual words of advice and motivation.

      (ever since then)
      I plan out each day to optimize my time for working on education projects, while trying to include time for family and friends.

      (and the moral of the story is)
   http://www.lifeclever.com/what-50-pounds-of-clay-can-teach-you-about-design/
      I heard a story about a ceramics teacher that split their class in two. One half produced as many pots as they could, the other had to produce on perfect pot. The half that produced more pots actually also produced better quality pots as well. So I am currently focused on building games from scratch, making as much as I can, and hoping that quality will increase over time, instead of making it perfect the first time. If you want to join me on this educational journey, please reach out.
-}


about : Html msg
about =
    div
        [ styles
            [ padding (px 100)
            ]
        ]
        [ p "Like most kids in the U.S., I went to school on the usual five day a week track for many years. I always enjoyed learning something new. Even more than that, I loved sharing that new piece of knowledge with those around me. If I learned something new at school, I would share it at home. If I learned something new at home, I would share it at school."
        , p "Slowly, school became less interesting to me. I was starting to do more tedious tasks. I didn't feel like I was learning as much anymore. The joy I had faded. I knew there had to be a better way to teach. I knew there had to be a better way to learn. I was going to figure out that way."
        , p "From an early age, I grew a strong desire to improve education. Continuing through schooling, that desire only became stronger."
        , p "When in college I decided on Computer Science as a major because I felt I could have the widest reach with this if I were to make any impact on education. I was lucky enough to get into the software industry straight out of college, but after a few years in the software industry, I do not feel anywhere close to my education goal."
        , p "I have come to learn that I need many years to make a quality educational game. It is challenging figuring out exactly how to structure a game, how to make a game enticing, how to make a game stick so people keep coming back, how to make that perfect educational game. I have some basic ideas of keeping the game simple, making it intuitive, having the learning being secondary to the task. But putting these things into practice and figuring out  all the little details of a game is extremely difficult."
        , p "I spend all the free time I have working towards my education passion in the best way I know how. But I do not know if I am spending enough time learning game programming, if I am spending enough time reaching out to educators to network, if I am spending enough time researching educational methods, or if I am spending enough time researching what games are already out there. I feel there is not enough time to do all the things I need to do."
        , p "I have to give credit to my fiancée here. She is an aerialist pursuing her passion in the circus world. She got me a passion planner and gives me continual words of advice and motivation. I use this planner to plan out each day to optimize my time for working on education projects, while trying to include time for family and friends."
        , p "I heard a story about a ceramics teacher that split his class in two. One half produced as many pots as they could, the other had to produce one perfect pot. The half that produced more pots actually also produced better quality pots as well. So I am currently focused on building games from scratch, making as many games as I can, and hoping that quality will increase over time, instead of making it perfect the first time. If you want to join me on this educational journey, please reach out, I look forward to hearing from you."
        ]


p : String -> Html a
p str =
    Html.p [] [ Html.text str ]



-- STYLE


styles =
    (Css.asPairs >> Attr.style)
