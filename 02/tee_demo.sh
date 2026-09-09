for i in {1..9}; do
    echo "$i bananas" | tee repeated_fruits.txt;
done

for i in {1..9}; do
    echo "$i bananas" | tee -a repeated_fruits.txt;
done
