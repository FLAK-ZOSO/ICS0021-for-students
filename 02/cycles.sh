a=2
b=10

# https://stackoverflow.com/a/13542854/15888601
if [[ a -gt b ]] then
    echo greater;
else
    echo nah;
fi

while [[ a -lt b ]] do
    a=$((a+1));
    echo $a;
done

