module Bingo exposing (..)


import Browser
import Html exposing (Html, button, select, input, option, div, text, ul, li, a, h1)
import Html.Events exposing (onClick, onInput)
import Html.Attributes as At exposing (..)
import String as Str
import Svg exposing (Svg, svg, rect, text, text_)
import Svg.Attributes as SAt exposing (..)
import Random exposing (Seed, generate)
import Random.List exposing (shuffle)
-- import Http

import Styles as S
import Array

-- TODOS

-- TODO: support localisation and create fi/en flag

-- MAIN

main =
  Browser.element { init = init
  , update = update
  , subscriptions = subscriptions,
   view = view }

-- SUBS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- MODEL

type alias Model =
  { payload : String
  , buttonPressed : Bool
  , bingoList : List String
  , size : Int
  , number : Int}

init : () -> (Model, Cmd Msg)
init _ =
  ({ payload = ""
   , buttonPressed = False
   , bingoList = []
   , size = 16
   , number = 1}
  , Cmd.none)


-- UPDATE

type Msg
  = Generate
  | NewList (List String)
  | ChangeSize String
  | ChangeNumber String


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Generate ->
        ({ model | buttonPressed = True }, generate NewList (shuffle cliches))
    NewList shuffled ->
      ({ model | bingoList = shuffled }, Cmd.none)
    ChangeSize size ->
      ({ model | size = Maybe.withDefault 0 (Str.toInt size)}, Cmd.none)
    ChangeNumber no ->
      ({ model | number = Maybe.withDefault -1 (Str.toInt no)}, Cmd.none)

-- DRAWING


squares : Int -> List String -> Html Msg
squares size list = div S.divStyle (sets size list)

sets : Int -> List String -> List (Html Msg)
sets size list = case size of
      16 ->
        [svg [SAt.width "600", SAt.height "600"] (squares4by4 0 0 list)]
      25 ->
        [svg [SAt.width "750", SAt.height "750"] (squares5by5 0 0 list)]
      _ ->
        [svg [SAt.width "750", SAt.height "750"] (squares4by4 0 0 [])]



squares4by4 : Int -> Int -> List String -> List (Svg Msg)
squares4by4 x y li = case (x,y,li) of
    (_,_,[])   -> drawSquare 0 0 "error"
    (_,600,_)  -> [] -- reached end of 4x4 squares
    (600,_,_)  -> squares4by4 0 (y+150) li -- reached end of line
    (_,_,(z::zs))    -> (drawSquare x y z)++(squares4by4 (x+150) y zs)

squares5by5 : Int -> Int -> List String -> List (Svg Msg)
squares5by5 x y li = case (x,y,li) of
    (_,_,[])   -> drawSquare 0 0 "error"
    (_,750,_)  -> [] -- reached end of 5x5 squares
    (750,_,_)  -> squares5by5 0 (y+150) li -- reached end of line
    (_,_,(z::zs))    -> (drawSquare x y z)++(squares5by5 (x+150) y zs)


drawSquare : Int -> Int -> String -> List (Svg Msg)
drawSquare xc yc txt =
    [rect
    [ x (Str.fromInt xc)
    , y (Str.fromInt yc)
    , SAt.width "150"
    , SAt.height "150"
    , SAt.stroke "black"
    , SAt.fill "transparent"] [] ]
    ++ formatText (xc+15) (yc+50) txt


formatText : Int -> Int -> String -> List (Svg Msg)
formatText xc yc txt =
    let boxSpecs = [ x (Str.fromInt (xc))
                   , y (Str.fromInt (yc))
                   , SAt.width "150"
                   , SAt.height "150"]
    in if (Str.length txt < 18 )
      then [text_ boxSpecs [text txt] ]
      else let start = Str.fromList <| List.take 17 (Str.toList txt)
               end = Str.fromList <| List.drop 17 (Str.toList txt)
      in [text_  boxSpecs [text (start++"-")]]
      ++ (formatText (xc) (yc+15) end)


{-

-- Here would be the smart way to merge and define 4x4 and 5x5, but it won't
-- work because the compiler interprets pattern matching max as "defining it
-- again". Only way is to define it would be by using "if - then - else -"

squares : Int -> List String -> Html Msg
squares size list = case size of
    16 ->
      div S.divStyle [svg
        [SAt.width "600", SAt.height "600"] (drawSquares 0 0 600 list)]
    25 ->
      div S.divStyle [svg
        [SAt.width "750", SAt.height "750"] (drawSquares 0 0 750 list)]
    _ ->
      div S.divStyle [svg
        [SAt.width "750", SAt.height "750"] (drawSquares 0 0 750 [])]



drawSquares : Int -> Int -> Int -> List String -> List (Svg Msg)
drawSquares x y max li = case (x,y,li) of
    (_,_,[])   -> drawSquare 0 0 "error"
    (_,max,_)  -> [] -- reached end of 4x4 squares
    (max,_,_)  -> drawSquares 0 (y+150) li -- reached end of line
    (_,_,(z::zs))    -> (drawSquare x y z)++(drawSquares (x+150) y zs)
-}


-- squares with text & borders
-- problem: printability ?
--squares2 : Html Msg
--squares2 =
--      div S.divStyle [div S.sqrStyle [text "höpöpölö"]]


-- VIEW


view : Model -> Html Msg
view model =
  div [] [
          -- CONTENT
          div S.contentStyle
            [h1 S.headingStyle [text "Euroviisu-bingo"]
            , div S.divStyle [text desc]
            , div S.divStyle [text "Yhden ruudukon koko:"]
            , div S.divStyle [select [onInput ChangeSize]
              [option [value "16"] [text "4x4"],
              option [value "25"] [text "5x5"]]
            ]
            , div S.divStyle [button (S.buttonStyle ++
                [ onClick Generate])
                [ text "Generoi!"] ]
            , if model.buttonPressed
              then squares (model.size) (model.bingoList)
              else div [] []
            ]
          ]


-- CONTENT

desc : String
desc =
    "Generoi satunnaisia Euroviisu-kliseitä sisältävä bingoruudukko!"


cliches : List String
cliches =
    ["Tuulikone", "Suomen lippu katsomossa", "Asunvaihdos",
    "Pakko laulaa mukana", "Ylireippaat tanssijat", "Laahus tai liehukkeet",
     "Modulaatio","Wtf-hetki", "Suomi saa 12 pistettä", "Vilkutus kameraan",
    "Balladi", "Maailmanparannusbiisi", "Joku ylösalaisin", "Vanhus lavalla",
    "Siansaksaa lyriikoiden joukossa", "Lentosuukko",
    "Pisteiden antaja jää juttelemaan liian pitkään juontajan kanssa",
    "Valtava laahus, jota esiintyjä ei pysty (itse) liikuttamaan",
    "Laulaja iskee silmää kameralle",
    "Mies laulaa säkeistot, nainen laulaa kertsit",
    "Juontajat vitsailevat ennalta sovitusti ja epärennosti",
    "Juontajat \"piilo\"-mainostaa oheiskrääsää",
    "Häviäjä yrittää hymyillä reippaasti",
    "Joku viime vuosien voittajista näkyy muualla kuin esityksessä",
    "Juontaja kertoo, että artisti on itse suunnitellut pukunsa",
    "Tukka tötteröllä", "Koskettava kohtalo", "Disko-humppa",
    "Artisti on alle 18-vuotias ja se mainitaan erikseen juonnossa",
    "Laulajalla on rooliasu (ammatti, hahmo, tms.)",
    "Naislaulaja riisuu pitkän mekon tai takin", "Mieslaulaja riisuu takin",
    "Tanssijat nostavat laulajan ilmaan",
    "Laulaja soittaa pari säveltä jollain instrumentilla ja sitten hylkää"++
    "sen loppubiisin ajaksi",
    "Laulajan kaula-aukko ulottuu napaan asti"]
