#!/data/data/com.termux/files/usr/bin/bash
# Add stock images to AI Body blog posts

IMGDIR="blog/img"
BLOGDIR="blog/posts"

declare -A IMG_MAP
IMG_MAP["ai-anti-aging-fitness-longevity-protocols"]="fitness-workout"
IMG_MAP["ai-blood-analysis-biomarker-decoding"]="medical-tech"
IMG_MAP["ai-blood-biomarker-analysis-fitness"]="medical-tech"
IMG_MAP["ai-body-composition-tracking-beyond-the-scale"]="body-composition"
IMG_MAP["ai-body-recomposition-fat-loss-muscle-gain"]="body-composition"
IMG_MAP["ai-body-transformation-case-studies-real-results"]="transformation"
IMG_MAP["ai-fitness-automation-no-tech-skills"]="ai-technology"
IMG_MAP["ai-form-correction-computer-vision-perfect-exercise-technique"]="fitness-workout"
IMG_MAP["ai-habit-formation-fitness-routines-that-stick"]="fitness-workout"
IMG_MAP["ai-home-gym-training-smart-tech"]="gym-equipment"
IMG_MAP["ai-hrv-training-cardiovascular-fitness"]="running"
IMG_MAP["ai-injury-prevention-machine-learning-workout-setbacks"]="medical-tech"
IMG_MAP["ai-meal-planning-smart-nutrition"]="healthy-food"
IMG_MAP["ai-metabolic-adaptation-break-weight-loss-plateaus"]="body-composition"
IMG_MAP["ai-nutrient-timing-post-workout-optimization"]="healthy-food"
IMG_MAP["ai-periodization-training-cycles"]="strength-training"
IMG_MAP["ai-powered-recovery-optimization"]="sleep-recovery"
IMG_MAP["ai-running-coach-endurance-training-optimization"]="running"
IMG_MAP["ai-sleep-optimization-fitness-recovery"]="sleep-recovery"
IMG_MAP["ai-strength-training-periodization-adaptive-programming"]="strength-training"
IMG_MAP["ai-stress-management-fitness-recovery"]="yoga-stress"
IMG_MAP["ai-vs-traditional-personal-training"]="ai-technology"
IMG_MAP["how-ai-personalizes-your-fitness-plan"]="ai-technology"
IMG_MAP["how-sleep-optimization-with-ai-supercharges-body-transformation"]="sleep-recovery"

cd /data/data/com.termux/files/home/workspace/ai-fit-blueprint

for file in "$BLOGDIR"/*.html; do
    base=$(basename "$file" .html)
    img_base="${IMG_MAP[$base]}"
    
    if [ -z "$img_base" ]; then
        echo "SKIP $base — no image mapping"
        continue
    fi
    
    img_file="$IMGDIR/${img_base}.jpg"
    if [ ! -f "$img_file" ]; then
        echo "SKIP $base — missing $img_file"
        continue
    fi
    
    if grep -q '<img src="../img/' "$file" || grep -q '<img src="img/' "$file"; then
        echo "SKIP $base — already has image"
        continue
    fi
    
    # Insert after <div class="meta"> line (the closing </div> or first <p> after it)
    # Match the pattern: <div class="meta">...</div> followed by blank lines then <p>
    sed -i '/<div class="meta">/{n;n;a\<img src="../img/'"${img_base}"'.jpg" alt="'"${base//-/ }"'" style="width:100%;max-width:720px;height:auto;border-radius:12px;margin:0 auto 24px;display:block;" />
}' "$file"
    
    echo "ADDED img to $base ($img_base.jpg)"
done

echo "Done with AI Body!"
