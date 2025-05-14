module Patrol.ClientSpec where

import qualified Network.HTTP.Client as Http.Client
import Network.HTTP.Client.TLS (getGlobalManager)
import qualified Network.HTTP.Types as Http.Types
import qualified Network.URI as Uri
import qualified Patrol
import qualified Patrol.Client as Patrol.Client
import qualified Patrol.Type.Dsn as Patrol.Dsn
import qualified Patrol.Type.Event as Patrol.Event
import qualified Test.Hspec as Hspec

spec :: Hspec.Spec
spec = Hspec.describe "Patrol.Client" $ do
  Hspec.fit "successfully submits an event to Kent" $ do
    event <- Patrol.Event.new
    manager <- getGlobalManager
    response <- Patrol.Client.store manager kentDsn event
    (Http.Types.statusIsSuccessful . Http.Client.responseStatus $ response)
      `Hspec.shouldBe` True

kentDsn :: Patrol.Dsn
kentDsn =
  let mDsn = Patrol.Dsn.fromUri =<< Uri.parseURI "http://public@127.0.0.1:5000/1"
   in maybe (error "invalid dsn") id mDsn
