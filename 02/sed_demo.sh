for i in {1..9}; do
    echo "$i bananas" >> repeated_fruits.txt;
done

sed "s/banana/apple/g" repeated_fruits.txt
sed -i "s/banana/apple/g" repeated_fruits.txt
