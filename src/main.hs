import System.IO
import System.Directory

main :: IO ()
main = do
  home  <- getHomeDirectory
  local <- doesFileExist ".octopus"
  if local then runOctopus ".octopus"
           else runOctopus (home ++ "/.octopus")
                      
--dummy function
runOctopus :: FilePath -> IO ()
runOctopus file = do
  withFile file ReadWriteMode 
    (\handle -> do
        contents <- hGetContents handle
        putStrLn contents)