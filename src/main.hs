import System.IO
import System.Directory

main :: IO ()
main = do
  local <- doesFileExist localFile
  if local then runOctopus localFile
           else runOctopus userGlobalFile
                where localFile = ".octopus"
                      userGlobalFile = "~/.octopus"
                      
--dummy function
runOctopus :: FilePath -> IO ()
runOctopus file = do
  withFile file ReadWriteMode 
    (\handle -> do
        contents <- hGetContents handle
        putStrLn contents)