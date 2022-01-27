from pytorch/pytorch:1.10.0-cuda11.3-cudnn8-runtime

RUN apt update && apt install -y libsm6 libxext6
RUN apt-get install -y libxrender-dev

RUN cd ..
RUN pip install scikit-learn
RUN pip install scikit-image
RUN pip install Pillow
RUN pip install matplotlib
RUN pip install numpy
RUN pip install pandas
RUN pip install monai==0.6.0
RUN pip install nibabel
RUN pip install tensorboard
RUN pip install itk
RUN pip install tqdm
RUN pip install torchvision
RUN pip install matplotlib

RUN pip install jupyter
# Add Tini. Tini operates as a process subreaper for jupyter. This prevents kernel crashes.
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
COPY init.sh /init.sh
RUN chmod +x /init.sh
ENTRYPOINT ["/usr/bin/tini", "--"]
#ENTRYPOINT ["/init.sh"]
CMD ["/init.sh"]
#CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
