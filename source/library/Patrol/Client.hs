module Patrol.Client where

import qualified Control.Monad.Catch as Catch
import qualified Control.Monad.IO.Class as IO
import qualified Network.HTTP.Client as Client
import qualified Patrol.Type.Dsn as Dsn
import qualified Patrol.Type.Event as Event

store ::
  (IO.MonadIO io, Catch.MonadThrow io) =>
  Client.Manager ->
  Dsn.Dsn ->
  Event.Event ->
  io (Client.Response ())
store manager dsn event = do
  request <- Event.intoRequest dsn event
  IO.liftIO $ Client.httpNoBody request manager
