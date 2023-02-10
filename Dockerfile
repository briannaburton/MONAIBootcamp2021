from pytorch/pytorch:1.9.0-cuda10.2-cudnn7-runtime

RUN apt update && apt install -y libsm6 libxext6 libxrender-dev gcc wget build-essential libssl-dev libffi-dev libsqlite3-dev libbz2-dev lzma liblzma-dev

## Python 3.9
WORKDIR /tmp
RUN wget https://www.python.org/ftp/python/3.9.9/Python-3.9.9.tgz && tar xzf Python-3.9.9.tgz && ./Python-3.9.9/configure && \
make && make altinstall && rm -rf /tmp/Python-3.9.9*

RUN /usr/local/bin/python3.9 --version

#RUN conda update -n base -c defaults conda
#RUN conda create -n monai_env python=3.9
# Make RUN commands use the new environment:
#SHELL ["conda", "run", "-n", "monai_env", "/bin/bash", "-c"]

#RUN python --version

RUN /usr/local/bin/python3.9 -m pip install --upgrade pip setuptools==59.5.0 wheel 
RUN /usr/local/bin/python3.9 -m pip install torch==1.9.0+cu111 torchvision==0.10.0+cu111 torchaudio===0.9.0 -f https://download.pytorch.org/whl/torch_stable.html
RUN /usr/local/bin/python3.9 -c "import torch; print(torch.cuda.is_available())"

COPY requirements.txt /requirements.txt
RUN /usr/local/bin/python3.9 -m pip install -r /requirements.txt
RUN rm /opt/conda/bin/python && ln -s /usr/local/bin/python3.9 /opt/conda/bin/python

WORKDIR /MONAILabel/
#RUN conda activate monai_env
