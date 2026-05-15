<h1 align="center">C.H.A.S.E.R</h1>
<h4 align="center">CHAotic Secure Encryption for Real-time audio</h4>

---

<p align="center">
  <a href="#abstract">Abstract</a> •
  <a href="#methodology">Methodology</a> •
  <a href="#photoshoot">Photoshoot</a> •
  <a href="#demo">Demo</a> •
  <a href="#credits">Credits</a>
</p>

---

## Abstract

The digital standards for encryption today are RSA and AES; however, not every system can utilize their benefits. For instance, low-powered electronics and pure analog RF systems cannot support intensive algorithms like those listed above. This presents an alternative: hardware-based encryption, specifically using chaotic behavior and amplitude modulation techniques.

This project utilizes Chua's circuit, the simplest chaotic emitting circuit. Unlike digital encryption where keys exist digitally, this system's key is the hardware itself — using precise resistor and capacitor values. This principle exploits chaos theory's extreme parameter sensitivity, where circuits with only identical parameters synchronize and enable decryption, while circuits with just 1–2% component mismatches break decryption entirely.

Audio signals are encrypted by multiplication with two synchronized Chua circuit outputs and a 40 kHz carrier. The carrier translates encrypted signals above the audio band, enabling clean filtering during decryption. Matched chaotic frequencies reverse the encryption only when component values are identical.

Testing measured security by varying decryption circuit parameters from 0% to 10% mismatch. Signal-to-noise ratio degraded from 23.2 dB to 19.4 dB, while the noise floor increased by 120%. Audio becomes unintelligible at 2–5% mismatch, establishing that standard 5% tolerance components are insufficient — requiring attackers to have 1% precision matching and physical circuit access.

The system exhibits 43.46% harmonic distortion limiting audio clarity due to multiple multiplication steps; despite this, the work validates that hardware parameter sensitivity creates practical security for specialized applications where digital approaches cannot be used.

---

## Methodology

Chua's circuit was selected for this prototype as the simplest circuit capable of producing chaotic behavior. Its extreme sensitivity to initial conditions and parameter variations makes it well-suited for encryption. Amplitude modulation was chosen as the encryption methodology for its simplicity and low cost while still providing thorough encryption.

**Diagram of Chua's Circuit:**

<img width="816" height="530" alt="Chua's Circuit Diagram" src="https://github.com/user-attachments/assets/15919f60-adb4-49c6-817e-b608c4e559be" />

**LTSpice Simulation:**

<img width="1593" height="902" alt="LTSpice Simulation" src="https://github.com/user-attachments/assets/632020d1-60e8-4c3e-9da1-5ad39047be1b" />

A 40 kHz carrier effectively separates the audio and key signals without significant overlap. Without the carrier, the Chua signal and audio would overlap considerably, reducing clarity. A Wien bridge oscillator is used alongside AD633 multiplier ICs to modulate the carrier, audio, and Chua circuit signals together.

---

## Photoshoot

**Double-scroll attractor:**

<img width="1024" height="600" alt="Double-Scroll Phenomenon" src="https://github.com/user-attachments/assets/3e3b16bc-a2f4-4bce-a354-11990e291f86" />

**Oscilloscope results:**

Photo of results (Blue: input signal, Yellow: encypted signal, Pink: Decrypted signal, Green: after filtering):

<img width="1369" height="654" alt="Oscilloscope Results" src="https://github.com/user-attachments/assets/eeabf48d-0f60-4d37-8678-f7515fed4ca7" />

---

## Demo

Listen to me explain the project while utilizing chaotic encryption:

[![chuacircuitencryption](https://img.youtube.com/vi/cD2RPHPB4YI/0.jpg)](https://www.youtube.com/watch?v=cD2RPHPB4YI)

---

## Credits

[1] V. Siderskiy, "Chua Circuits," *Chua Circuits*. [Online]. Available: https://chuacircuits.com/. Accessed: Feb. 14, 2026.

[2] A. Shaik, "Amplitude Modulation – Physics and Radio-Electronics," *Physics and Radio-Electronics*. [Online]. Available: https://www.physics-and-radio-electronics.com/blog/amplitude-modulation/. Accessed: Feb. 15, 2026.

[3] L. Pecora and T. Carroll, "Synchronization in Chaotic Systems," *Physical Review Letters*, vol. 64, pp. 821–823, 1990. Accessed: Feb. 15, 2026.

[4] L. Kocarev, K. S. Halle, K. Eckert, L. O. Chua, and U. Parlitz, "Experimental demonstration of secure communications via chaotic synchronization," *Int. J. Bifurc. Chaos*, vol. 2, no. 3, pp. 709–713, 1992. Accessed: Feb. 15, 2026.

[5] E. Nazarenko, N. A. Anagnostopoulos, S. G. Stavrinides, N. Mexis, F. Frank, T. Arul, and S. Katzenbeisser, "Real-World Chaos-Based Cryptography Using Synchronized Chua Chaotic Circuits," *arXiv*, 2022. [Online]. Available: https://arxiv.org/abs/2210.11299. Accessed: Feb. 15, 2026.

[6] S. Baowidan, "Chaos-Driven Encryption Algorithm Integrated Logistic Chua Map for Secure Medical Image Communication," 2024. DOI: 10.21203/rs.3.rs-4692013/v1. Accessed: Feb. 15, 2026.

[7] "Electronic filters explained: from low pass to band stop," *Kistler*. [Online]. Available: https://www.kistler.com/NL/en/filter-electronics-/C00000109. Accessed: Feb. 16, 2026.
