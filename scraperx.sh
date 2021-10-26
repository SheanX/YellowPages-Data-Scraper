#! /bin/bash


#TEXT COLORS
YELLOW='\033[1;33m'
RED='\033[0;31m'
L_GREEN='\033[1;32m'
L_BLUE='\033[1;34m'
D_GREY='\033[1;30m'
L_GREY='\033[0;37m'
NC='\033[0m' # No Color

#PROJECT VARIABLES
YPURL="" # Yellow Pages URL
URL_VALID=true
PAGE_NU="&page=2"

printf "\n\n"
printf "${YELLOW}#### Welcome to Yellow Pages Scraper ####${NC}\n\n"

printf "${L_GREEN}Enter the Yellow Pages URL below:${NC}\n"
printf "${D_GREY}example :https://www.yellowpages.com${NC}\n"
#printf "example :https://www.yellowpages.com/search?search_terms=doctors&geo_location_terms=Los+Angeles%2C+CA${NC}\n"
read YPURLL
#printf "\n${L_GREEN}Your URL IS = ${L_GREY}$YPURLL\n\n${NC}"
echo -ne  "\n${L_GREEN}Your URL IS = ${L_GREY}$YPURLL\n\n${NC}"



#URL VALIDATION FUNCTION
URL_VALIDITY_CHECK(){
#regex='^(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]\.[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]$'
regex='^'
 

##url='http://www.google.com/test/link.php'
if [[ $PURLL =~ $regex ]]
then 
    printf "\n\n${L_BLUE}Entered URL is  valid${NC}\n\n"
    URL_VALID==true
else
    printf "\n\n${RED}Entered URL is not valid${NC}\n\n"
    URL_VALID==false
fi
}

#URL_VALIDITY_CHECK

curl $YPURLL >> /tmp/yweb



####To check the curl web curl result and appending the result
if [ $? -eq 0 ]; then
   printf "\n${L_BLUE}#Web page curling started${NC}\n\n"
  # curl $PURLL > /tmp/yweb.txt
else
   printf "\n${RED}Web page curling error. Programme terminated${NC}\n\n"
   exit 1
fi


printf "\n\n"



#To extract only the phone numbers and append the to testp.txt file
grep -Eo '\(?[[:digit:]]{3}\)?[[:space:]]?[[:digit:]]{3}-[[:digit:]]{4}' /tmp/yweb > testp.txt



#To check the result of above command successful/unsucessful
if [ $? -eq 0 ]; then
   printf "\n${L_BLUE}#Web page scraping successful.${NC}\n\n"
else
   printf "\n${RED}#Web page scraping unsucessful. Programme terminated${NC}\n\n"
   exit 1
fi


#Loop to open up all pages
for i in {2..7}
do
 PAGE_NU="&page=$i"
 YPURLLX="$YPURLL$PAGE_NU"
 curl $YPURLLX > /tmp/yweb
 grep -Eo '\(?[[:digit:]]{3}\)?[[:space:]]?[[:digit:]]{3}-[[:digit:]]{4}' /tmp/yweb >> testp.txt
done


#To delete duplicate entries
sort -u testp.txt > testpp.txt


#Show success message
printf "\n\n${L_BLUE}You have scraped $i pages succesfuly${NC}\n\n"






