from pytorch/pytorch:1.9.0-cuda10.2-cudnn7-runtime

RUN apt update && apt install -y libsm6 libxext6
RUN apt-get update && apt-get install -y libxrender-dev gcc
RUN conda update -n base -c defaults conda
RUN conda create -n monai_env python=3.9
# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "monai_env", "/bin/bash", "-c"]
RUN python -m pip install --upgrade pip setuptools wheel
RUN pip install torch==1.9.0+cu111 torchvision==0.10.0+cu111 torchaudio===0.9.0 -f https://download.pytorch.org/whl/torch_stable.html
RUN python -c "import torch; print(torch.cuda.is_available())"
COPY requirements.txt /requirements.txt
Run pip install -r /requirements.txt
RUN conda init bash
