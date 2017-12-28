module Main where

import Control.Monad
import Control.Monad.IO.Class
import Control.Concurrent
import Control.Concurrent.STM

import Data.Foldable

import System.Process
import System.IO
import System.Console.Haskeline

alpha :: String
alpha = ['a' .. 'z']

main :: IO ()
main = do
  (Just stdin', _,  _, _) <- createProcess $
    (shell "./authenticate") { std_in = CreatePipe }

  v <- newTVarIO ""

  void . forkIO . forever $ do
    x <- atomically (readTVar v)
    forM_ alpha $ \c ->
      hPutStrLn stdin' (x ++ [c])

  runInputT defaultSettings $ forever $ do
    x <- getInputLine "Enter guess> "
    liftIO (traverse_ (atomically . writeTVar v) x)
