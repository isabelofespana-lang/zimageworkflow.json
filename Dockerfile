# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# Could not resolve unknown_registry custom node 'LoraLoaderModelOnly' - no aux_id provided; skipped
# Could not resolve unknown_registry custom node 'PromptHistoryInput' - no aux_id provided; skipped
# Could not resolve unknown_registry custom node 'ConditioningZeroOut' - no aux_id provided; skipped
# Could not resolve unknown_registry custom node 'ClownsharKSampler_Beta' - no aux_id provided; skipped
RUN comfy-node-install comfyui-kjnodes ComfyUI-PromptHistoryGallery RES4LYF
 


# download models into comfyui
RUN comfy model download --url https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/diffusion_models/z_image_turbo_bf16.safetensors --relative-path models/diffusion_models --filename z_image_turbo_bf16.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/vae/ae.safetensors --relative-path models/vae --filename ae.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/text_encoders/qwen_3_4b.safetensors --relative-path models/text_encoders --filename qwen_3_4b.safetensors
RUN comfy model download --url https://huggingface.co/datasets/isabelofespana/zimagelora/resolve/main/RealisticSnapshot-Zimage-Turbov5.safetensors --relative-path models/loras --filename RealisticSnapshot-Zimage-Turbov5.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
