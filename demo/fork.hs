module Main where

import Control.Monad
import Control.Concurrent

import System.Mem

main :: IO ()
main = do
  forM_ [1..32] $ \i -> forkIO $ forever $ do
    putStrLn ("PING: " ++ show i)
    (threadDelay (1 * 10^6))

  void getLine
