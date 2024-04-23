# after activating env and setting up accelerate...
langs=(py js java cpp swift php d jl lua r rkt rs)

for lang in "${langs[@]}"; do
    # use humaneval for py and multipl-e for the rest
    if [ "$lang" == "py" ]; then
        task=humaneval
    else
        task=multiple-$lang
    fi

    echo "Running task $task"
    generations_path=generations_$model/generations_$task\_$model.json
    accelerate launch main.py \
            --model $org/$model \
            --task $task \
            --n_samples 50 \
            --batch_size 50 \
            --max_length_generation 512 \
            --temperature 0.2 \
            --precision bf16 \
            --trust_remote_code \
            --generation_only \
            --save_generations_path $generations_path
    echo "Task $task done"
done