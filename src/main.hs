import System.IO
import System.Environment
import System.Directory

import Data.Maybe

--the following functions will be moved to a different module

dispatch :: [(String, FilePath -> [String] -> IO ())]
dispatch = [("add", add),
            ("view",view),
            ("remove",remove)]
------

--the following functions might be replaced

errorExit :: String -> IO ()
errorExit arg = putStrLn ("command " ++ arg ++ " is invalid.")

argumentCheck :: [String] -> [String]
argumentCheck args = if null args then ["view"]
                                  else args

------

main :: IO ()
main = do
  home  <- getHomeDirectory
  local <- doesFileExist ".octopus"
  if local then runOctopus ".octopus"
           else runOctopus (home ++ "/.octopus")
                     
runOctopus :: FilePath -> IO ()
runOctopus file = do
  args <- getArgs
  let (command:arguments) = argumentCheck args
      queryResponse = lookup command dispatch
  if isJust queryResponse then let (Just task) = queryResponse 
                               in task file arguments
                          else errorExit command

--dummy functions
add :: FilePath -> [String] -> IO ()
add file args = if (length args) >= 2 then let (activity:time:rest) = args
                                          in runAdd file activity time --change here to warn if arguments have been ignored
                                     else putStrLn "insuficient arguments for command add"
                                       
view :: FilePath -> [String] -> IO ()
view file args = putStrLn "function view dummied"

remove :: FilePath -> [String] -> IO ()
remove file args = putStrLn "function remove dummied"

--actual execution
runAdd :: FilePath -> String -> String -> IO ()
runAdd file activity time = appendFile file (activity ++ " " ++ time ++ "\n")
                            