dit() {                          # This is a definition of dit, the sleep is how long It lasts       
        curl https://lampy.dangrain.top/H 
        sleep 0.1 
        curl https://lampy.dangrain.top/L 
}

dah() {  # same as abvoe just for dah 
        curl https://lampy.dangrain.top/H 
        sleep 0.3
        curl https://lampy.dangrain.top/L 
}

space() {
        sleep 0.3  # space :)
}


declare -A morse # we define the whole alphabet
morse[a]=".-"
morse[b]="-..."
morse[c]="-.-."
morse[d]="-.."
morse[e]="."
morse[f]="..-."
morse[g]="--."
morse[h]="...."
morse[i]=".."
morse[j]=".---"
morse[k]="-.-"
morse[l]=".-.."
morse[m]="--"
morse[n]="-."
morse[o]="---"
morse[p]=".--."
morse[q]="--.-"
morse[r]=".-."
morse[s]="..."
morse[t]="-"
morse[u]="..-"
morse[v]="...-"
morse[w]=".--"
morse[x]="-..-"
morse[y]="-.--"
morse[z]="--.."
morse[1]=".----"
morse[2]="..---"
morse[3]="...--"
morse[4]="....-"
morse[5]="....."
morse[6]="-...."
morse[7]="--..."
morse[8]="---.."
morse[9]="----."
morse[0]="-----"



send_letter() { # function that sends the letters (calls dit and dah)
    local letter=$1
    code=${morse[$letter]}

    for ((i=0; i<${#code}; i++)); do
        char=${code:$i:1}
        if [[ $char == "." ]]; then
            dit
        elif [[ $char == "-" ]]; then
            dah
        fi
        space
    done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    if [[ $# -gt 0 ]]; then
        "$@"
        exit 0
    fi

    echo "Input your text. Lowercase only"

    read inputted_text
    curl https://lampy.dangrain.top/L # we ensure Lampy's off before sending
    my_string="${inputted_text}"

    char_array=() 

    for (( i=0; i<${#my_string}; i++ )); do
        char_array+=("${my_string:$i:1}") # go through the string picking out letters and putting them into char_array
    done


    for char in "${char_array[@]}"; do
        send_letter "$char"  # this is where we actually send the characters
	sleep 0.1 # delay between parts of the same letter
    done
fi
