import React from 'react';
import {StyleSheet, Image} from 'react-native';

const styles = StyleSheet.create({
  image: {width: 24, height: 20, marginTop: 2, opacity: 0.3},
});
export const Calendar = () => {
  return <Image style={styles.image} source={require('./calendar.png')} />;
};
