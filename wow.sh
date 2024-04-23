# define prefixes base on codegeex-2 repo
declare -A langs
langs=( [py]="# Python" [js]="// JavaScript" [java]="// Java" [cpp]="// C++" [swift]="// Swift" [php]="// PHP" [jl]="# Julia" [lua]="// Lua" [r]="# R" [rkt]="; Racket" [rs]="// Rust" [d]="" )

for lang in "${!langs[@]}"; do
    prefix="language: ${langs[$lang]}"
    echo "For language $lang, the prefix is: $prefix"
    generations_path=generations_$model/generations_$task\_$model.json
    accelerate launch main.py \
            --model "$org/$model" \
            --task "multiple-l$ang" \
            --n_samples 5 \
            --batch_size 5 \
            --limit 8 \
            --max_length_generation 512 \
            --temperature 0.2 \
            --precision bf16 \
            --trust_remote_code \
            --use_auth_token \
            --generation_only \
            --save_generations_path $generations_path \
            --prefix \"$prefix\" \
    echo "Task $task done"
done