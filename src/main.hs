import System.IO
import System.Environment
import System.Directory

import Data.Maybe

--the following functions will be moved to a different module

dispatch :: [(String, [String] -> IO ())]
dispatch = [("add", add),
            ("view",view),
            ("remove",remove)]
------

--the following functions might be replaced

errorExit :: String -> IO ()
errorExit arg = putStrLn ("command " ++ arg ++ " is invalid.")

------

main :: IO ()
main = do
  home  <- getHomeDirectory
  local <- doesFileExist ".octopus"
  if local then runOctopus ".octopus"
           else runOctopus (home ++ "/.octopus")
                     
runOctopus :: FilePath -> IO ()
runOctopus file = do
  (command:arguments) <- getArgs
  let queryResponse = lookup command dispatch
  if isJust queryResponse then let (Just task) = queryResponse 
                               in task arguments
                          else errorExit command

--dummy functions
add :: [String] -> IO ()
add args = putStrLn "function add dummied"

view :: [String] -> IO ()
view args = putStrLn "function view dummied"

remove :: [String] -> IO ()
remove args = putStrLn "function remove dummied"